require 'spec_helper'

describe 'Admin ImportFile' do

  before { as :admin }
  before(:all) { set_resource 'admin-import-file' }

  let(:import_file) { create(:import_file) }

  let(:student) { create(:student) }

  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click_link 'Importer'
      click new_link
    end

    it 'creates and shows' do
      expect do
        absolute_path = Rails.root + '../support/new_students.csv'
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

  context 'importing', js: true do
    before do
    end

    it 'create student' do
      student
      import_file
      $redis.rpush "import_file:#{import_file.id}:created", student.id
      visit gaku.admin_root_path
      click_link 'Importer'
      click new_link

      click '.check-link'
      click '#created-students-tab-link'
      has_content? student.name
      has_content? student.surname
      expect(page.all('#created-students-index tbody tr').count).to eq 1
    end

    it 'duplicate student' do
      student
      import_file
      $redis.rpush "import_file:#{import_file.id}:duplicated", student.id
      visit gaku.admin_root_path
      click_link 'Importer'
      click new_link

      click '.check-link'
      click '#duplicated-students-tab-link'
      has_content? student.name
      has_content? student.surname
      expect(page.all('#duplicated-students-index tbody tr').count).to eq 1
    end

    it 'not saved student' do
      import_file
      $redis.rpush "import_file:#{import_file.id}:not_saved", "10052014, John, Doe"
      visit gaku.admin_root_path
      click_link 'Importer'
      click new_link

      click '.check-link'
      click '#not-saved-students-tab-link'
      has_content? '10052014'
      has_content? 'John'
      has_content? 'Doe'
      expect(page.all('#not-saved-students-index tbody tr').count).to eq 1
    end


  end


  context 'existing', js: true do

    before do
      import_file
      visit gaku.admin_root_path
      click_link 'Importer'
    end

    it 'import' do
      click '.import-link'
      expect(page).to have_content('Importing for students started!')

    end

    it 'deletes' do
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
