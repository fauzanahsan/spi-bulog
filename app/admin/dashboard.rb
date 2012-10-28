ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }   
  
  content  do #:title => proc{ "Koordinator Wilayah" }
    columns do
      column do
        
        if current_admin_user.has_role? "Korwaswil"
          panel "Koordinator Wilayah : #{current_admin_user.entity.wilayah}" do
            @entities = Entity.where(:wilayah => current_admin_user.entity.wilayah) #current_admin_user.entity.wilayah
            table do   
              th do 'Entitas' end
              th do 'Proses' end
              
              @entities.each do |ent|
                tr do
                  td do 
                    ent.entitas 
                  end
      
                  td do
                    if ent.entitas == current_admin_user.entity.entitas
                      if ent.pkpt_aktif.blank? 
                        link_to("Baru", new_admin_pkpt_path)
                      elsif ent.pkpt_aktif.status == "Disetujui"
                        link_to("Proses LHP", admin_pkpt_path(ent.pkpt_aktif.id))
                      else
                        link_to("Edit", admin_pkpt_path(ent.pkpt_aktif.id))
                      end
                    else
                      link_to("Lihat", admin_pkpt_path(ent.pkpt_aktif.id)) if !ent.pkpt_aktif.blank? 
                    end  
                  end
                end
              end
            
            end #end table              
          end #end panel
        end
        
        if current_admin_user.has_role? "Kabidwas"
          panel "Kabidwas" do
            @entities = Entity.all #current_admin_user.entity.wilayah
            table do   
              th do 'Entitas' end
              th do 'Proses' end
              
              @entities.each do |ent|
                tr do
                  td do 
                    ent.entitas 
                  end
      
                  td do
                      link_to("Lihat", admin_pkpt_path(ent.pkpt_aktif.id)) if !ent.pkpt_aktif.blank? 
                  end
                end
              end
            
            end #end table              
          end #end panel
        end
        
        if current_admin_user.has_role? "Staff"
          panel "PKPT" do
            
            table do   
              th do 'Entitas' end
              th do 'Proses' end
              
              tr do
                td do 
                  current_admin_user.entity.entitas 
                end
    
                td do
                    link_to("Edit", admin_pkpt_path(current_admin_user.entity.pkpt_aktif.id)) if !current_admin_user.entity.pkpt_aktif.blank? 
                end
              end
            
            end #end table              
          end #end panel
        end
        
        if current_admin_user.has_role? "Staff Tata Usaha"
          panel "Rekapitulasi PKPT" do
            
            table do   
              th do 'Periode' end
              th do 'Proses' end
              
              tr do
                td do 
                  "2012"
                end
    
                td do
                  if Recapitulation.find_by_periode("2012").nil?
                    link_to("Buat", new_admin_recapitulation_path )  
                  else
                    link_to("Edit", edit_admin_recapitulation_path(Recapitulation.find_by_periode("2012").id))  
                  end
                end
              end
            
            end #end table              
          end #end panel
        end
        
        
      end
    end
    
  end
  
end
