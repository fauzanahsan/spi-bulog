class Recapitulation < ActiveRecord::Base
  has_many :pkpt_recapitulations
  has_many :pkpts, :through => :pkpt_recapitulations
  
  attr_accessible :periode, :keterangan_pembuka, :keterangan_penutup
  
  def direkap
    self.status_rekap = "Direkap"
    save
  end
                  
end
