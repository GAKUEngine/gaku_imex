module Gaku
  module Importers
    class StudentsWorker

      include Sidekiq::Worker
      sidekiq_options retry: false

      def perform(file_import_id, path)
        Gaku::Importers::Students::Csv.new(file_import_id, path).import
      end

    end
  end
end
