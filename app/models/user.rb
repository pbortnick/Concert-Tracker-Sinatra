class User < ActiveRecord::Base
  has_many :concerts
  has_secure_password

end
