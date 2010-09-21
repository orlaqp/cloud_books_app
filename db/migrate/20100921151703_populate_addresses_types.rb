class PopulateAddressesTypes < ActiveRecord::Migration
  def self.up

    AddressType.new(:description => "Home").save
    AddressType.new(:description => "Work").save
    AddressType.new(:description => "Other").save

  end

  def self.down
    AddressType.find_by_description("Home").delete
    AddressType.find_by_description("Work").delete
    AddressType.find_by_description("Other").delete
  end
end
