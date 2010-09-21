class CreateContactsInternetInfosJoinTable < ActiveRecord::Migration
  def self.up
    create_table :contacts_internet_infos, :id => false do |t|
      t.integer :contact_id
      t.integer :internet_info_id
    end
  end

  def self.down
    drop_table :contacts_internet_infos
  end
end
