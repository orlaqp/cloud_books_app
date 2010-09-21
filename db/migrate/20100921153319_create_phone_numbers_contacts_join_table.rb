class CreatePhoneNumbersContactsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :contacts_phone_numbers, :id => false do |t|
      t.integer :contact_id
      t.integer :phone_number_id
    end
  end

  def self.down
    drop_table :contacts_phone_numbers
  end
end
