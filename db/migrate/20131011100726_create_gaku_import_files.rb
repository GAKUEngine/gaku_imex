class CreateGakuImportFiles < ActiveRecord::Migration
  def change

    create_table :gaku_import_files do |t|
      t.string   'context'
      t.string   'importer_type'
      t.string   'data_file_file_name'
      t.string   'data_file_content_type'
      t.integer  'data_file_file_size'
      t.datetime 'data_file_updated_at'
    end

  end
end
