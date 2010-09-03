class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :phone_numbers do |t|
      t.string :type
      t.string :number

      t.timestamps
    end
  end

  def self.down
    drop_table :phone_numbers
  end
end
