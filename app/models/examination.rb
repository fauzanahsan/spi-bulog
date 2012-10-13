class Examination < ActiveRecord::Base
  attr_accessible :uraian, :rekomendasi, :tanggapan, :status
  
  belongs_to :lhp
end
