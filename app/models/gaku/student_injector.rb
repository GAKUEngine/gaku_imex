require 'csv'

module Gaku
  Student.class_eval do

    def self.as_csv
      CSV.generate do |csv|
        csv << csv_column_fields
        all.each { |student| csv << student.attributes.values_at(*csv_column_fields) }
      end
    end

    def as_csv
      CSV.generate do |csv|
        csv << self.class.csv_column_fields
        csv << self.attributes.values_at(*self.class.csv_column_fields)
      end
    end

    # private

    def self.csv_column_fields
      %w(
        name surname middle_name
        name_reading surname_reading middle_name_reading
        serial_id foreign_id_code
        gender birth_date admitted national_registration_code
      )
    end

  end
end
