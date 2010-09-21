class PopulateInternetInfoTypes < ActiveRecord::Migration
  def self.up

    InternetInfoType.new(:description => "Email").save
    InternetInfoType.new(:description => "Webpage").save
    InternetInfoType.new(:description => "IM").save

  end

  def self.down
  end
end
