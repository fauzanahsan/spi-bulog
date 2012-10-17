ActiveAdmin.register Pkpt do
  menu :label => "PKPT"
  controller.authorize_resource
  
  form do |f| 
    f.inputs do 
      f.input :wilayah_mock, :label => "Wilayah", :input_html => { :value => current_admin_user.entity.provinsi, :disabled => true } 
      f.input :entity_mock, :label => "Entitas", :input_html => { :value => current_admin_user.entity.kota, :disabled => true }                           
      f.input :periode, :as => :select, :collection => ['2012','2013','2014']    
      if !f.object.new_record?
        f.input :status, :as => :select, :collection => Pkpt::DOC_STATUS
      end
      f.input :notes, :label => "Catatan" #, :input_html => { :disabled=>true }
      f.input :entity_id, :as => :hidden, :input_html => { :value => current_admin_user.entity.id }   
      f.input :wilayah, :as => :hidden, :input_html => { :value => current_admin_user.entity.provinsi }    
    end
    f.buttons                         
  end
  
  
end
