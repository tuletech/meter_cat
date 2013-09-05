# This migration comes from meter_cat (originally 20130904180803)
class CreateMeterCatMeters < ActiveRecord::Migration
  def change
    create_table :meter_cat_meters do |t|
      t.string :name, :limit => 64, :null => false
      t.date :created_on
      t.integer :value, :default => 0
      t.integer :lock_version, :default => 0
      t.datetime :created_at
      t.index [ :created_on, :name ], :unique => true
    end
  end
end
