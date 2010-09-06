class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :firstname, :limit => 50
      t.string :lastname, :limit => 50
      t.string :username, :limit => 25
      t.string :password, :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
