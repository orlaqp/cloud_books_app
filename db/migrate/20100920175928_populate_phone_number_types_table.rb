class PopulatePhoneNumberTypesTable < ActiveRecord::Migration
  def self.up
	PhoneNumberType.new(:name => "Home").save
	PhoneNumberType.new(:name => "Work").save
	PhoneNumberType.new(:name => "Cellular").save	
  end

  def self.down
	PhoneNumberType.find_by_name("Home").delete
	PhoneNumberType.find_by_name("Work").delete
	PhoneNumberType.find_by_name("Cellular").delete
  end
end
