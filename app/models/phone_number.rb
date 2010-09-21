class PhoneNumber < ActiveRecord::Base

  belongs_to :phone_number_type
  has_and_belongs_to_many :addresses

end
