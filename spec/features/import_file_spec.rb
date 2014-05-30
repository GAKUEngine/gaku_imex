require 'spec_helper'

describe 'Admin ImportFile' do

  before { as :admin }
  before(:all) { set_resource 'admin-import-file' }

  let(:import_file) { create(:import_file) }

  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click_link 'Importer'
      click new_link
    end

    it 'creates and shows' do
      expect do
        absolute_path = Rails.root + '../support/student.csv'
        attach_file 'import_file_data_file', absolute_path
        select 'students', from: 'import_file_importer_type'
        click submit
        flash_created?
      end.to change(Gaku::ImportFile, :count).by 1

      has_content? 'students'
      has_content? 'Import files list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do

    before do
      import_file
      visit gaku.admin_root_path
      click_link 'Importer'
    end

    it 'deletes', js: true do
      has_content? import_file.data_file_file_name
      count? 'Import files list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::ImportFile, :count).by(-1)

      has_no_content? import_file.data_file_file_name
    end

  end
end
