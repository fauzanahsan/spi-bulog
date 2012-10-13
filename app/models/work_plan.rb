class WorkPlan < ActiveRecord::Base
  attr_accessible :description, :status
  belongs_to :team
  belongs_to :work_plan_category
  belongs_to :pkpt
    
  has_many :lhps

end
