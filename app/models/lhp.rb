class Lhp < ActiveRecord::Base
  attr_accessible :keterangan, :pre_keterangan, :post_keterangan, :tanggal_awal, :tanggal_akhir, 
                  :program_pemeriksaan, :status, :maksud_tujuan, :work_plan_id, :entity_id, :team_attributes,
                  :pendahuluan, :penutup, :examinations_attributes
                  
  has_many :examinations
  has_one :team
  accepts_nested_attributes_for :team
  accepts_nested_attributes_for :examinations
  
  belongs_to :entity
  belongs_to :work_plan
  
  def dikirim
    self.status = "Dikirim"
    save
  end
  
end
