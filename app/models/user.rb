class User < ActiveRecord::Base
  
  def self.authenticate(username, password)
    
    user = User.where("username = ? AND password = ?", username, password)
    return user
    
  end
    
  
end
