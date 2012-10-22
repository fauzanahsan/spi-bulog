ActiveAdmin.register Examination do
  menu :label => "Hasil Pemeriksaan"
  controller.authorize_resource
  
  index do
    column("Kode LHP"){|examination| examination.lhp.id }
    column("Kode Hasil Pemeriksaan", :id)
    column(:uraian)
    column(:rekomendasi)
    column("Status", :status)
    column("Tanggal Proses"){ |examination| examination.created_at.strftime("%d %B %Y") } 
    default_actions
  end
  
  form do |f| 
    f.inputs do
      if params[:lhp]
        f.input :lhp_id, :as => :hidden, :input_html => { :value => params[:lhp] }  
      elsif f.object.new_record?
        f.input :lhp
      end
      f.input :uraian #, :label => "Staff", :input_html => { :value => current_admin_user.fullname, :disabled => true } 
      f.input :rekomendasi #, :label => "Kategori Rencana Kerja", :as => :select, :collection => Hash[WorkPlanCategory.all.map{|w| [w.name,w.id]}] 
      f.input :tanggapan #, :label => "Tanggal Proses", :as => :datepicker
      
      f.buttons
    end              
  end
  
  show do |examination|
    attributes_table do
      row 'Kode Hasil Pemeriksaan' do
        examination.id
      end
      
      row 'Kode LHP' do
        examination.lhp.id
      end
      
      row 'Uraian' do
        examination.uraian
      end
      
      row 'Rekomendasi' do
        examination.rekomendasi
      end
      
      row 'Tanggapan' do
        examination.tanggapan
      end
      
      row 'Status' do
        examination.status
      end
      
      row 'Tanggal Proses' do
        examination.created_at.strftime("%d %B %Y")
      end
      
    end
    
  end
  
  
end
