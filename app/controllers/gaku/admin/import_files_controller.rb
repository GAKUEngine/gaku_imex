module Gaku
  class Admin::ImportFilesController < Admin::BaseController

    respond_to :js

    skip_authorization_check

    before_action :set_import_file, only: %i( destroy import check )

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

    def import
      @import_file.import
      flash.now[:notice] = t(:'import_file.importing', type: @import_file.importer_type)
      respond_with @import_file
    end

    def check
      @created_students    = Gaku::Student.where(id: created_students)
      @duplicated_students = Gaku::Student.where(id: duplicated_students )
      @not_saved_students  = not_saved_students

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

    def created_students
      $redis.lrange("import_file:#{@import_file.id}:created", 0, -1)
    end

    def duplicated_students
      $redis.lrange("import_file:#{@import_file.id}:duplicated", 0, -1)
    end

    def not_saved_students
      $redis.lrange("import_file:#{@import_file.id}:not_saved", 0, -1)
    end

  end
end
