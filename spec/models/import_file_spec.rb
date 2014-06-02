require 'spec_helper'

describe Gaku::ImportFile do

  describe 'validations' do
    it { should have_attached_file :data_file }
    it { should validate_presence_of :data_file }
    it { should validate_presence_of :importer_type }
  end

  describe 'Types' do
    it 'includes students type' do
      expect(described_class::Types).to include 'students'
    end
  end

  describe '#file_absolute_path' do
    it 'returns file absolute path' do
      import_file = create(:import_file)
      expect(import_file.file_absolute_path).to eq "#{Rails.root}/public#{import_file.data_file.url(:original, false)}"
    end
  end

  describe '#import' do
    it 'calls Gaku::Importers::StudentsWorker' do
      import_file = create(:import_file, importer_type: 'students')
      expect(Gaku::Importers::StudentsWorker).to receive(:perform_async)
      import_file.import
    end
  end

end
