ActiveAdmin.register AdminUser do
  menu :label => "Staff", :if => proc{ can?(:manage, AdminUser)  } 
  controller.authorize_resource
       
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "User Details" do
      f.input :email       
      f.input :entity, :label => "Entitas", :as => :select, :collection => Hash[Entity.all.map{|e| [e.entitas,e.id]}]                          
      f.input :fullname, :label => "Nama Lengkap" 
      f.input :phone, :label => "Phone"                  
      f.input :password               
      f.input :password_confirmation
      f.input :roles, :as => :select, :collection => Role.all  
    end                               
    f.buttons                         
  end                                 
end                                   
