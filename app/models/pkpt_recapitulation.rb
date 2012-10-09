class PkptRecapitulation < ActiveRecord::Base
  attr_accessible :keterangan_pembuka, :keterangan_penutup
  belongs_to :pkpt
end
