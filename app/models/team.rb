class Team < ActiveRecord::Base
  attr_accessible :name, :leader_id
  
  has_many :admin_user_teams
  has_many :admin_users, :through => :admin_user_teams
  has_one :work_plan
end
