require 'csv'

module Gaku
  Student.class_eval do

    # def self.as_csv
    #   CSV.generate do |csv|
    #     csv << column_names
    #     all.each { |item| csv << item.attributes.values_at(*column_names) }
    #   end
    # end

    # def as_csv
    #   CSV.generate do |csv|
    #     values = []

    #     csv << csv_column_fields
    #     csv_column_fields.each { |value| values << self.send(value) }

    #     csv << values
    #   end
    # end

    # private

    def self.csv_column_fields
      %i( serial_id foreign_id_code
          name surname middle_name
          name_reading surname_reading middle_name_reading
          gender birth_date admitted  national_registration_code )
    end

  end
end
