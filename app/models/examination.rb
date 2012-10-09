class Examination < ActiveRecord::Base
  attr_accessible :uraian, :rekomendasi, :tanggapan, :status
  
  has_many :lhps
end
