class WorkPlan < ActiveRecord::Base
  attr_accessible :description, :status, :created_by, :catatan_pengembalian, :work_plan_category_id, 
                  :pkpt_id, :team_id, :tanggal_proses, :work_plan_details, :created_by_id
  
  belongs_to :work_plan_category
  belongs_to :pkpt
    
  has_many :lhps
  has_one :team
  
  def returned?
    self.status == "Dikembalikan"
  end
  
  def dikembalikan
    self.status = "Dikembalikan"
    save
  end

end
