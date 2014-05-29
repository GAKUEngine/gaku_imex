module Gaku
  class Admin::ImportFilesController < Admin::BaseController

    skip_authorization_check

    private

    def import_params
      params.require(:importer).permit(:data_file, :importer_type)
    end

  end
end
