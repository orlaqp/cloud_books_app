class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :title, :limit => 5
      t.string :first_name, :limit => 50
      t.string :middle, :limit => 50
      t.string :last_name, :limit => 50
      t.string :suffix, :limit => 15
      t.string :job_title, :limit => 100
      t.string :company, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
