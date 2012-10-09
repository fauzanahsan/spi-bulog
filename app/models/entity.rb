class Entity < ActiveRecord::Base
  has_many :admin_users
  has_many :pkpts
  has_many :lhps
  
  attr_accessible :kota, :alamat, :phone, :fax, :status, :keterangan, :direktur, :kecamatan, :kabupaten, :provinsi

end
