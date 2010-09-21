class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :address_type_id
      t.string :street, :limit => 250
      t.string :city, :limit => 100
      t.string :state, :limit => 100
      t.string :zip_code, :limit => 15
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
