ActiveAdmin.register Team do
  controller.authorize_resource
  
  form do |f|
    if params[:work_plan_id] 
      work_plan = WorkPlan.find(params[:work_plan_id])
      f.inputs do  
        f.input :work_plan_id_mock, :label => "Kode Rencana Kerja", :input_html => { :value => work_plan.id, :disabled => true }
        f.input :pkpt_id_mock, :label => "Kode PKPT", :input_html => { :value => work_plan.pkpt.id, :disabled => true }
        f.input :penanggung_jawab_mock, :label => "Penanggung Jawab", :input_html => { :value => work_plan.staff_input, :disabled => true }
        f.input :input_staff_mock, :label => "Staff", :input_html => { :value => work_plan.staff_input, :disabled => true }
        f.input :work_plan_category_mock, :label => "Kategori Rencana Kerja", :input_html => { :value => work_plan.work_plan_category.name, :disabled => true }
        f.input :status_mock, :label => "Status", :input_html => { :value => work_plan.status, :disabled => true }     
        f.input :tanggal_proses_mock, :label => "Tanggal Proses", :input_html => { :value => work_plan.tanggal_proses.strftime("%d %B %Y"), :disabled => true }
        f.input :work_plan_details_mock, :label => "Rencana Kerja", :input_html => { :value => work_plan.work_plan_details, :disabled => true }  
        f.input :work_plan_id, :as => :hidden, :input_html => { :value => work_plan.id }        
      end
    end                         
    f.inputs "Tim Pengawas" do       
      f.input :leader_id, :label => "Ketua Tim", :as => :select, :collection => Hash[AdminUser.all.map{|u| [u.email,u.id]}] 
      f.input :admin_users, :label => "Anggota", :as => :check_boxes, :collection => Hash[AdminUser.all.map{|u| ["#{u.fullname} (#{u.email})",u.id]}] 
    end                               
    f.buttons                         
  end
end
