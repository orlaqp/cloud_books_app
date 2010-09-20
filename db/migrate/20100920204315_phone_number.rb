class PhoneNumber < ActiveRecord::Migration
  def self.up
    create_table :phone_numbers do |t|
      t.integer :phone_number_type_id
      t.string :phone_number
    end
  end

  def self.down
    drop_table :phone_numbers
  end
end
