class WorkPlanCategory < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :work_plans
end
