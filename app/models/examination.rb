class Examination < ActiveRecord::Base
  attr_accessible :uraian, :rekomendasi, :tanggapan, :status, :lhp_id
  
  belongs_to :lhp
end
