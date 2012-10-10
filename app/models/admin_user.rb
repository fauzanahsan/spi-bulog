class AdminUser < ActiveRecord::Base
  
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  ROLES = ["Admin"]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids, :fullname, :phone
  # attr_accessible :title, :body
  has_many :admin_user_teams
  has_many :teams, :through => :admin_user_teams
end
