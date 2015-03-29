class AdminUser < ActiveRecord::Base
  # Devise macros
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
