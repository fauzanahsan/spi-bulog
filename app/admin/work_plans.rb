ActiveAdmin.register WorkPlan do
  menu :parent => "Rencana Kerja", :label => "List Rencana Kerja"
  controller.authorize_resource
  
  index do
    column("Kode PKPT", :pkpt_id)
    column("Kode Rencana Kerja", :id)
    column("Status", :status)
    column("Deskripsi", :description)
    column("Staff", :staff_input)
    column("Tanggal Proses"){ |wp| wp.tanggal_proses.strftime("%d %B %Y") } 
    column("Tanggal Dibuat", :created_at)
    default_actions
  end
  
  form do |f| 
    f.inputs do
      if params[:dikembalikan]
        f.input :work_plan_id_mock, :label => "Kode Rencana Kerja", :input_html => { :value => f.object.id, :disabled => true }
        f.input :pkpt_id_mock, :label => "Kode PKPT", :input_html => { :value => f.object.pkpt.id, :disabled => true }
        f.input :penanggung_jawab_mock, :label => "Penanggung Jawab", :input_html => { :value => f.object.staff_input, :disabled => true }
        f.input :input_staff_mock, :label => "Staff", :input_html => { :value => f.object.staff_input, :disabled => true }
        f.input :work_plan_category_mock, :label => "Kategori Rencana Kerja", :input_html => { :value => f.object.work_plan_category.name, :disabled => true }
        f.input :work_plan_details_mock, :label => "Rencana Kerja", :input_html => { :value => f.object.work_plan_details, :disabled => true }
        f.input :tanggal_proses_mock, :label => "Tanggal Proses", :input_html => { :value => f.object.tanggal_proses.strftime("%d %B %Y"), :disabled => true }
        f.input :catatan_pengembalian, :label => "Catatan Pengembalian"
        f.input :status, :as => :hidden, :input_html => { :value => "Dikembalikan" } 
        f.buttons do
          f.commit_button :label => "Kembalikan"
        end
      else
        if params[:pkpt]
          f.input :pkpt_id, :as => :hidden, :input_html => { :value => params[:pkpt] }
          f.input :pkpt_id_mock, :label => "Kode PKPT", :input_html => { :value => params[:pkpt], :disabled => true } 
        else
          f.input :pkpt_id, :label => "Kode PKPT"
        end
        f.input :staff_input_mock, :label => "Staff", :input_html => { :value => current_admin_user.fullname, :disabled => true } 
        f.input :work_plan_category_id, :label => "Kategori Rencana Kerja", :as => :select, :collection => Hash[WorkPlanCategory.all.map{|w| [w.name,w.id]}] 
        f.input :tanggal_proses, :label => "Tanggal Proses", :as => :datepicker
        f.input :description, :label => "Deskripsi"    
        f.input :work_plan_details, :label => "Rencana Kerja"
        f.input :staff_input, :as => :hidden, :input_html => { :value => current_admin_user.fullname } 
        
        f.buttons
      end
      
    end                     
  end
  
  show do |work_plan|
    attributes_table do
      row 'Kode Rencana Kerja' do
        work_plan.id
      end
      
      row 'Kode PKPT' do
        work_plan.pkpt.id
      end
      
      row 'Penanggung Jawab' do
        work_plan.staff_input
      end
      
      row 'Staff' do
        work_plan.staff_input
      end
      
      row 'Kategori Rencana Kerja' do
        work_plan.work_plan_category.name
      end
      
      row 'Status' do
        work_plan.status
      end
      
      row 'Tanggal Proses' do
        work_plan.tanggal_proses.strftime("%d %B %Y")
      end
      
      row 'Deskripsi Rencana Kerja' do
         work_plan.description
      end
      
      row 'Rencana Kerja' do
        work_plan.work_plan_details
      end
      
    end
    
  end
  
end
