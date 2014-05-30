FactoryGirl.define do

  factory :import_file, class: Gaku::ImportFile do
    importer_type 'students'
    data_file do
      fixture_file_upload(Rails.root + '../support/student.csv',
                          'text/csv')
    end
  end


end
