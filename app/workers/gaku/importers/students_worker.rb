module Gaku
  module Importers
    class StudentsWorker

      include Sidekiq::Worker
      sidekiq_options retry: false

      def perform(import_file_id, path)
        Gaku::Importers::Students::Csv.new(import_file_id, path).import
      end

    end
  end
end
