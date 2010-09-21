class CreateInternetInfoTypes < ActiveRecord::Migration
  def self.up
    create_table :internet_info_types do |t|
      t.string :description, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :internet_info_types
  end
end
