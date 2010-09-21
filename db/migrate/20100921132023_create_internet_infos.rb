class CreateInternetInfos < ActiveRecord::Migration
  def self.up
    create_table :internet_infos do |t|
      t.integer :internet_info_type_id
      t.string :description, :limit => 150

      t.timestamps
    end
  end

  def self.down
    drop_table :internet_infos
  end
end
