class Pkpt < ActiveRecord::Base
  belongs_to :entity
  has_many :work_plans
  has_many :pkpt_recapitulations
  
  attr_accessible :keterangan_awal, :periode, :status, :entity_id, :notes, :wilayah
  
  DOC_STATUS = ['Diinput', 'Dikirim', 'Disetujui', 'Dikembalikan']
  
  def disetujui
    self.status = "Disetujui"
    save
  end
  
  def dikirim
    self.status = "Dikirim"
    save
  end
  
  
end
