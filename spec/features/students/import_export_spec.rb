require 'spec_helper'

describe 'Student Sheet', js: true do

  before { as :admin }

  let!(:student) { create(:student, name: 'John', surname: 'Doe') }
  let!(:student2) { create(:student, name: 'Susumu', surname: 'Yokota') }

  context 'download' do
    it 'downloads registration sheet', js: true do
      visit gaku.admin_root_path
      click '#importer-master-menu a'
      click_link 'Student Importer'
     # click_link 'import-students-link'
     # click_link 'get_registration_csv'

     # page.response_headers['Content-Type'].should eq "text/csv"
     # page.should have_content 'surname,name,surname_reading,name_reading,gender,phone,email,birth_date,admitted'
    end
  end

  context 'upload' do
    xit 'imports from sheet' do
      visit gaku.students_path
      expect do
        click_link 'import-students-link'
        select 'Roster', from: 'importer_importer_type'
        absolute_path = Rails.root + '../support/sample_roster.xls'
        attach_file 'importer_data_file', absolute_path
        click_button 'Import'
      end.to change(Gaku::Student, :count).by 2

      #page.should have_content 'created students:2'
    end
  end

end
