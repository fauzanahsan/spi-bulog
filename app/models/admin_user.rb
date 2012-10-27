class AdminUser < ActiveRecord::Base
  
  rolify :role_cname => 'Role'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  ROLES = ["Admin", "Korwaswil", "Kabidwas", "Direksi", "Kepala SPI", "Staff", "Staff Tata Usaha", "Team Pengawas"]
    
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids, :fullname, :phone, :entity_id
  belongs_to :entity
  # attr_accessible :title, :body
  has_many :admin_user_teams
  has_many :teams, :through => :admin_user_teams
  
  def own_pkpt
    self.entity.pkpt_aktif
  end
  
end
