class Contact < ActiveRecord::Base

  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :phone_numbers
  has_and_belongs_to_many :internet_infos

end
