module Gaku
  module Importers
    class StudentsWorker

      include Sidekiq::Worker
      sidekiq_options retry: false

      def perform(file_path)
        Gaku::Importers::Students::Csv.new(file_path).import
      end

    end
  end
end