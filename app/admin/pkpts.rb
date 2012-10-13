ActiveAdmin.register Pkpt do
  menu :label => "PKPT"
  controller.authorize_resource
  
  form do |f| 
    f.inputs do 
      f.input :entity, :label => "Entitas", :as => :select, :collection => Hash[Entity.all.map{|e| [e.kota,e.id]}]                          
      f.input :periode, :as => :datepicker
      f.input :status
      f.input :keterangan_awal, :label => "Keterangan Awal"
      f.input :notes, :label => "Catatan" #, :input_html => { :disabled=>true }
    end
    f.buttons                         
  end
  
  
end
