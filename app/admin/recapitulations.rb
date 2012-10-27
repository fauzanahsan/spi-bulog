ActiveAdmin.register Recapitulation do
  menu :label => "Rekapitulasi PKPT", :if => proc{ can?(:manage, Recapitulation) }
  controller.authorize_resource
  
  form do |f|  
    f.inputs do
      if f.object.new_record?  
        f.input :periode, :as => :select, :collection => ['2012', '2013', '2014']
      else
        f.input :periode, :label => "Kode Rencana Kerja", :input_html => { :disabled => true }
      end
      f.input :keterangan_pembuka
      f.input :pkpts, :as => :select, :collection => Hash[Pkpt.all.map{|p| [p.entity.entitas, p.id]}] 
      f.input :keterangan_penutup
    end                            
    f.buttons                         
  end
end
