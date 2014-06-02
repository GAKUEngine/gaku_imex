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
    it 'creates new student' do
      expect do
        described_class.new('spec/support/student.csv').import
      end.to change(Gaku::Student, :count).by(1)
    end

    it 'saves all attributes' do
      described_class.new('spec/support/student.csv').import
      created_student = Gaku::Student.last
      expect(created_student.name).to eq 'Amon'
      expect(created_student.surname).to eq 'Tobin'
      expect(created_student.name_reading).to eq 'Amon'
      expect(created_student.surname_reading).to eq 'Tobin'
      expect(created_student.gender).to eq true
      expect(created_student.birth_date.to_s).to eq '1983-01-01'
    end
  end
end