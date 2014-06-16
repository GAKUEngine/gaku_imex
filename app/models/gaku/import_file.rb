module Gaku
  class ImportFile < ActiveRecord::Base

    validates :data_file, :importer_type, presence: true

    has_attached_file :data_file

    Types = %w( students )

    def import
      case importer_type
      when 'students'
        klass = "Gaku::Importers::#{importer_type.capitalize}Worker".constantize
        klass.perform_async(id, file_absolute_path)
      end
    end

    def file_absolute_path
      "#{Rails.root}/public#{data_file.url(:original, false)}"
    end

  end
end
