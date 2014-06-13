require 'spec_helper'

describe Gaku::Importers::Students::Csv do

  let!(:import_file) { create(:import_file) }

  describe 'initialize' do
    it 'initializes' do
      expect(described_class.new(import_file.id, 'spec/support/new_students.csv').csv)
        .to eq [{:national_registration_code=>999,
                  :name=>"零紀",
                  :middle_name=>"Flux",
                  :surname=>"影月",
                  :name_reading=>"レイキ",
                  :middle_name_reading=>"フラックス",
                  :surname_reading=>"カゲツキ",
                  :gender=>1,
                  :birth_date=>"2006-04-19",
                  :enrollment_status_code=>"enrolled"
              }]
    end
  end

  describe '#import' do
    subject { described_class.new(import_file.id, 'spec/support/new_students.csv').import }

    it 'creates new student' do
      expect do
        subject
      end.to change(Gaku::Student, :count).by(1)
    end

    it 'saves all attributes' do
      subject

      created_student = Gaku::Student.last
      expect(created_student.name).to eq '零紀'
      expect(created_student.surname).to eq '影月'
      expect(created_student.name_reading).to eq 'レイキ'
      expect(created_student.surname_reading).to eq 'カゲツキ'
      expect(created_student.gender).to eq true
      expect(created_student.birth_date.to_s).to eq '2006-04-19'
    end

    it 'sets enrollment status' do
      subject

      created_student = Gaku::Student.last
      expect(created_student.enrollment_status.code).to eq 'enrolled'
    end

    it 'returns an array of created students' do
      students = subject
      created_student = Gaku::Student.last
      expect($redis.lrange "import_file:#{import_file.id}:created", 0, -1).to eq [created_student.id.to_s]
      expect($redis.llen "import_file:#{import_file.id}:created").to eq 1
      expect($redis.llen "import_file:#{import_file.id}:not_saved").to eq 0
    end

    xit 'ignores records with ID set to prevent tainting the DB' do
      students = described_class.new('spec/support/students.csv').import
      expect(students[:created].count).to eq 0
    end

    it 'imports students from a foreign system' do
       described_class.new(import_file.id, 'spec/support/foreign_system_students.csv').import
      expect($redis.llen "import_file:#{import_file.id}:created").to eq 2
    end

    it 'checks foreign_id_code and does not overwrite or re-create existing records' do
      create(:student, foreign_id_code: 55567)
      create(:student, foreign_id_code: 55568)

      described_class.new(import_file.id, 'spec/support/foreign_system_students.csv').import
      expect($redis.llen "import_file:#{import_file.id}:created").to eq 0
      expect($redis.llen "import_file:#{import_file.id}:duplicated").to eq 2
    end

    it 'returns an array of students with errors' do
      described_class.new(import_file.id, 'spec/support/format_error_students.csv').import
      expect($redis.llen "import_file:#{import_file.id}:not_saved").to eq 2
    end
  end
end
