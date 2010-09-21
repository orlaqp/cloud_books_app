class CreateAddressTypes < ActiveRecord::Migration
  def self.up
    create_table :address_types do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :address_types
  end
end
