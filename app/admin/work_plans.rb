ActiveAdmin.register WorkPlan do
  menu :parent => "Rencana Kerja", :label => "Buat Rencana Kerja"
  controller.authorize_resource
  
  form do |f| 
    f.inputs do
      f.input :pkpt_id_mock, :label => "Kode PKPT", :input_html => { :value => params[:pkpt], :disabled => true } 
      f.input :staff_input_mock, :label => "Staff", :input_html => { :value => current_admin_user.fullname, :disabled => true } 
      f.input :work_plan_category_id, :label => "Kategori Rencana Kerja", :as => :select, :collection => Hash[WorkPlanCategory.all.map{|w| [w.name,w.id]}] 
      f.input :tanggal_proses, :label => "Tanggal Proses", :as => :datepicker    
      f.input :description, :label => "Rencana Kerja"
      f.input :staff_input, :as => :hidden, :input_html => { :value => current_admin_user.fullname } 
      f.input :pkpt_id, :as => :hidden, :input_html => { :value => params[:pkpt] } 
    end
    f.buttons                         
  end
  
end
