ActiveAdmin.register WorkPlan do
  menu false
  menu :parent => "Rencana Kerja", :label => "List Rencana Kerja", :if => proc{ can?(:manage, WorkPlan) }
  controller.authorize_resource
  
  index do
    column("Kode PKPT", :pkpt_id)
    column("Kode Rencana Kerja", :id)
    column("Status", :status)
    column("Deskripsi", :description)
    column("Staff", :staff_input)
    column("Tanggal Proses"){ |wp| wp.tanggal_proses.strftime("%d %B %Y") } 
    column("Tanggal Dibuat", :created_at)
    column("Proses"){ |wp| link_to("LHP", new_admin_lhp_path(:work_plan_id => wp.id)) } 
    default_actions
  end
  
  form do |f| 
    f.inputs do
      if params[:dikembalikan]
        f.input :work_plan_id_mock, :label => "Kode Rencana Kerja", :input_html => { :value => f.object.id, :disabled => true }
        f.input :pkpt_id_mock, :label => "Kode PKPT", :input_html => { :value => f.object.pkpt.id, :disabled => true }
        f.input :work_plan_category_mock, :label => "Kategori Rencana Kerja", :input_html => { :value => f.object.work_plan_category.name, :disabled => true }
        f.input :work_plan_details, :label => "Rencana Kerja", :input_html => { :disabled => true }
        f.input :status_mock, :label => "Status", :input_html => { :value => f.object.pkpt.status } 
        f.input :status, :as => :hidden, :input_html => { :value => "Dikembalikan" } 
        f.input :tanggal_proses_mock, :label => "Tanggal Proses", :input_html => { :value => f.object.created_at.strftime("%d %B %Y"), :disabled => true }
        f.input :catatan_pengembalian, :label => "Catatan Pengembalian"
        f.buttons do
          f.commit_button :label => "Kembalikan"
        end
      else  
        if params[:pkpt]
          f.input :pkpt_id, :as => :hidden, :input_html => { :value => params[:pkpt] }
          f.input :periode_mock, :label => "Periode", :input_html => { :value => Pkpt.find(params[:pkpt]).periode, :disabled => true } 
          f.input :entitas_mock,  :label => "Entitas", :input_html => { :value => Pkpt.find(params[:pkpt]).entity.entitas, :disabled => true } 
        end
        f.input :work_plan_category_id, :label => "Kategori Rencana Kerja", :as => :select, :collection => Hash[WorkPlanCategory.all.map{|w| [w.name,w.id]}] 
        if !f.object.new_record? 
          f.input :work_plan_id_mock,  :label => "Kode Rencana Kerja", :input_html => { :value => params[:id], :disabled => true } 
          f.input :status,  :label => "Status", :input_html => { :disabled => true } 
          f.input :created_at,  :label => "Tanggal Proses", :input_html => { :disabled => true } 
        end
        f.input :work_plan_details, :label => "Rencana Kerja"
        f.input :created_by, :as => :hidden, :input_html => { :value => current_admin_user.fullname } 
        f.input :created_by_id, :as => :hidden, :input_html => { :value => current_admin_user.id } 
        
        f.buttons
      end
      
    end                     
  end
  
  show do |work_plan|
    attributes_table do
      row 'Periode' do
        work_plan.pkpt.periode
      end
      
      row 'Entitas' do
        work_plan.pkpt.entity.entitas
      end
      
      row 'Kode Rencana Kerja' do
        work_plan.id
      end
      
      row 'Kode PKPT' do
        work_plan.pkpt.id
      end
      
      row 'Kategori Rencana Kerja' do
        work_plan.work_plan_category.name
      end
      
      row 'Status' do
        work_plan.status
      end
      
      row 'Tanggal Proses' do
        work_plan.created_at.strftime("%d %B %Y")
      end
      
      row 'Rencana Kerja' do
        raw work_plan.work_plan_details.gsub(/\n/, '<br/>')
      end
      
    end
    
  end
  
end
