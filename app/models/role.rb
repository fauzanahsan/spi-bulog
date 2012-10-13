class Role < ActiveRecord::Base
  has_and_belongs_to_many :admin_users, :join_table => :admin_users_roles
  belongs_to :resource, :polymorphic => true
  
  attr_accessible :name, :resource_type
  
  scopify
end
