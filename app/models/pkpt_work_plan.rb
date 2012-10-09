class PkptWorkPlan < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :pkpt
  belongs_to :work_plan
end
