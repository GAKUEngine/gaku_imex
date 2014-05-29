module Gaku::Importers::Students
  class Csv
    include Gaku::Importers::Students::StudentIdentity

    attr_reader :csv

    def initialize(file)
      @csv = SmarterCSV.process(file)
    end

    def import

    end


  end
end
