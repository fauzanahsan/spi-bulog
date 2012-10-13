class Lhp < ActiveRecord::Base
  attr_accessible :keterangan, :pre_keterangan, :post_keterangan, :tanggal_awal, :tanggal_akhir, 
                  :program_pemeriksaan, :status
                  
  has_many :examinations
  belongs_to :entity
  belongs_to :work_plan
end
