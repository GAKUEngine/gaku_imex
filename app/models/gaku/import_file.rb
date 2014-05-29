module Gaku
  class ImportFile < ActiveRecord::Base

    validates :data_file, :importer_type, presence: true

    has_attached_file :data_file

    Types = %w( students )

  end
end
