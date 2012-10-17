class WorkPlan < ActiveRecord::Base
  attr_accessible :description, :status, :staff_input, :catatan_pengembalian, :work_plan_category_id, 
                  :pkpt_id, :team_id, :tanggal_proses, :work_plan_details
  belongs_to :team
  belongs_to :work_plan_category
  belongs_to :pkpt
    
  has_many :lhps
  
  def returned?
    self.status == "Dikembalikan"
  end
  
  def dikembalikan
    self.status = "Dikembalikan"
    save
  end

end
