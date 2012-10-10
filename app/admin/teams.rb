ActiveAdmin.register Team do
  controller.authorize_resource
  
  form do |f|                         
    f.inputs "Team Details" do       
      f.input :name
      f.input :leader_id, :label => "Ketua Tim", :as => :select, :collection => Hash[AdminUser.all.map{|u| [u.email,u.id]}] 
      f.input :admin_users, :label => "Anggota", :as => :check_boxes, :collection => Hash[AdminUser.all.map{|u| [u.email,u.id]}] 
    end                               
    f.buttons                         
  end
end
