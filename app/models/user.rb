class User < ActiveRecord::Base
  validates_presence_of :login, :password, :email
  
  has_many :tasks
  
  PASSWORD_SALT = 've'
end
