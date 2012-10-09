class AdminUserTeam < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :admin_user
  belongs_to :team
end
