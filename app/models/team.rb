class Team < ActiveRecord::Base
  attr_accessible :name
  
  has_many :admin_user_teams
  has_one :work_plan
end
