class Examination < ActiveRecord::Base
  attr_accessible :uraian, :rekomendasi, :tanggapan, :status, :lhp_id, :status_tindak_lanjut, :catatan_pengembalian,
                  :tindak_lanjut
  
  belongs_to :lhp
end
