class CreateGakuReports < ActiveRecord::Migration
  def change
    create_table :gaku_reports do |t|
      t.string :name
      t.references :reportable, polymorphic: true

      t.timestamps null: false
    end
  end
end
