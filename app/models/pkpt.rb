class Pkpt < ActiveRecord::Base
  belongs_to :entity
  has_many :pkpt_work_plans
  has_many :pkpt_recapitulations
  
  attr_accessible :keterangan_awal, :periode, :status
  
end
