module Gaku
  class ImportFile < ActiveRecord::Base

    validates :data_file, :importer_type, presence: true

    has_attached_file :data_file

    Types = %w( students )

    def import
      begin
        klass = "Gaku::Importers::#{importer_type.capitalize}Worker".constantize
        klass.perform_async(file_absolute_path)
      rescue StandardError
        $stderr.puts "Importer for:  #{importer_type} is not supported!"
      end
    end

    def file_absolute_path
      "#{Rails.root}/public#{data_file.url(:original, false)}"
    end

  end
end
