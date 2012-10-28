class Team < ActiveRecord::Base
  attr_accessible :name, :leader_id, :admin_user_ids, :lhp_id
  
  has_many :admin_user_teams
  has_many :admin_users, :through => :admin_user_teams
  belongs_to :lhp 
  
  after_create :set_team_name
  
  def set_team_name
    self.name = "Team-#{self.id}"
    save
  end
end
