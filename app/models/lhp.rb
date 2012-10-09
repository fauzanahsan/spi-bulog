class Lhp < ActiveRecord::Base
  attr_accessible :keterangan, :pre_keterangan, :post_keterangan, :tanggal_awal, :tanggal_akhir, 
                  :program_pemeriksaan, :status
                  
  has_many :lhp_examinations
  belongs_to :entity
end
