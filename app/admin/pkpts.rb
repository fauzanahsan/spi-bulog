ActiveAdmin.register Pkpt do
  menu :label => "PKPT"
  controller.authorize_resource
  
  form do |f| 
    f.inputs do 
      f.input :entity, :label => "Entitas", :as => :select, :collection => Hash[Entity.all.map{|e| [e.kota,e.id]}]                          
      f.input :periode, :as => :select, :collection => ['2012','2013','2014']    
      if !f.object.new_record?
        f.input :status, :as => :select, :collection => Pkpt::DOC_STATUS
      end
      f.input :notes, :label => "Catatan" #, :input_html => { :disabled=>true }
    end
    f.buttons                         
  end
  
  
end
