require 'spec_helper'

describe Gaku::Importers::Students::Csv do
  describe 'initialize' do
    it 'initializes' do
      expect(described_class.new('spec/support/student.csv').csv)
        .to eq [{
          serial_id: 203,
          foreign_id_code: 2727,
          name: "Amon",
          surname: "Tobin",
          name_reading: "Amon",
          surname_reading: "Tobin",
          gender: "true",
          birth_date: "1983-01-01"
        }]
    end
  end

  describe '#import' do
    subject { described_class.new('spec/support/student.csv').import }

    it 'creates new student' do
      expect do
        subject
      end.to change(Gaku::Student, :count).by(1)
    end

    it 'saves all attributes' do
      subject

      created_student = Gaku::Student.last
      expect(created_student.name).to eq 'Amon'
      expect(created_student.surname).to eq 'Tobin'
      expect(created_student.name_reading).to eq 'Amon'
      expect(created_student.surname_reading).to eq 'Tobin'
      expect(created_student.gender).to eq true
      expect(created_student.birth_date.to_s).to eq '1983-01-01'
    end

    it 'sets enrollment status' do
      subject

      created_student = Gaku::Student.last
      expect(created_student.enrollment_status.code).to eq 'enrolled'
    end

    it 'returns an array of created students' do
      students = subject
      created_student = Gaku::Student.last
      expect(students[:created]).to eq [created_student]
      expect(students[:with_errors].count).to eq 0
      expect(students[:created].count).to eq 1
    end

    it 'returns an array of students with errors' do
      students = described_class.new('spec/support/student_with_error.csv').import
      expect(students[:with_errors].count).to eq 1
      expect(students[:created].count).to eq 0

    end
  end
end