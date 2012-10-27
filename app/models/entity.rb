class Entity < ActiveRecord::Base
  has_many :admin_users
  has_many :pkpts
  has_many :lhps
  
  attr_accessible :kota, :alamat, :phone, :fax, :status, :keterangan, :kecamatan, :kabupaten, :provinsi, 
                  :kode, :entitas, :wilayah, :kepala_entitas
  
  AKTIF = "2012"
                  
  def pkpt_aktif
    self.pkpts.where(:periode => AKTIF).first
  end

end
