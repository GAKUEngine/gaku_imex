module Gaku::Importers::Students
  class Csv
    include Gaku::Importers::Students::StudentIdentity

    attr_reader :csv

    def initialize(file_path)
      @csv = SmarterCSV.process(file_path)
    end

    def import
      ActiveRecord::Base.transaction do
        @csv.each_with_index do |row|
          student = Gaku::Student.new(row)
          student.save
        end
      end
    end

  end
end
