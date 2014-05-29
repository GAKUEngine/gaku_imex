module Gaku
  class Admin::ImportFilesController < Admin::BaseController

    respond_to :js

    skip_authorization_check

    before_action :set_import_file, only: :destroy

    def index
      @import_files = Gaku::ImportFile.all
      set_count
      respond_with @import_files
    end

    def new
      @import_file = Gaku::ImportFile.new
      respond_with @import_file
    end

    def create
      @import_file = Gaku::ImportFile.create(import_params)
      set_count
      respond_with @import_file
    end

    def destroy
      @import_file.destroy!
      set_count
      respond_with @import_file
    end

    private

    def set_import_file
      @import_file = Gaku::ImportFile.find(params[:id])
    end

    def import_params
      params.require(:import_file).permit(:data_file, :importer_type)
    end

    def set_count
      @count = Gaku::ImportFile.count
    end

  end
end
