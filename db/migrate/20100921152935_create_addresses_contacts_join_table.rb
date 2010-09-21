class CreateAddressesContactsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :addresses_contacts, :id => false do |t|
      t.integer :address_id
      t.integer :contact_id
    end

  end

  def self.down
    drop_table :addresses_contacts
  end
end
