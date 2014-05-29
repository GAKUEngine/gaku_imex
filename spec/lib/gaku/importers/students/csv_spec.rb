require 'spec_helper'

describe Gaku::Importers::Students::Csv do
  it 'initializes' do
    expect(described_class.new('spec/support/student.csv').csv)
      .to eq [{id: 1,
               name: "John",
               surname: "Doe",
               birth_date: "1983-10-05",
               code: "**-****-00001",
               serial_id: 1,
               foreign_id_code: 1,
               enrollment_status_code: "admitted",
               addresses_count: 1,
               contacts_count: 3,
               notes_count: 2,
               courses_count: 1,
               guardians_count: 1,
               external_school_records_count: 0,
               badges_count: 0,
               primary_address: "Nagoya, 1587 Zboncak Ridges",
               primary_contact: "Email: travis_barrows@quigley.biz",
               scholarship_status_id: 1,
               created_at: "2014-05-22 15:55:01 UTC",
               updated_at: "2014-05-22 15:55:05 UTC",
               extracurricular_activities_count: 0,
               class_groups_count: 0,
               deleted: "false"
             }]

  end
end