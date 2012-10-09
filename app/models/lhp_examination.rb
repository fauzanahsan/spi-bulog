class LhpExamination < ActiveRecord::Base
  #attr_accessible :title, :body
  belongs_to :lhp
  belongs_to :examination
end
