class InternetInfo < ActiveRecord::Base

  belongs_to :internet_info_type
  has_and_belongs_to_many :contacts

end
