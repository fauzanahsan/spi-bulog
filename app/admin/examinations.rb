ActiveAdmin.register Examination do
  menu false
  menu :label => "Hasil Pemeriksaan", :if => proc{ can?(:manage, Examination) }
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
      
      if !f.object.new_record?
        f.input :periode_mock, :label => "Periode", :input_html => { :value => f.object.lhp.work_plan.pkpt.periode, :disabled => true }
        f.input :program_kerja_mock, :label => "Program Kerja", :input_html => { :value => f.object.lhp.work_plan.work_plan_details, :disabled => true }
      end
      
      f.input :uraian, :input_html => { :disabled => current_admin_user.has_role?("Ketua Tim") }   
      f.input :rekomendasi, :input_html => { :disabled => current_admin_user.has_role?("Ketua Tim") }     
      f.input :tanggapan, :input_html => { :disabled => current_admin_user.has_role?("Ketua Tim") }   
      if params[:dikembalikan]
        f.input :catatan_pengembalian
        f.input :status, :as => :hidden, :input_html => { :value => "Dikembalikan" }  
    
        f.actions do
          f.action :submit, :label => "Dikembalikan" 
        end
        
      elsif params[:tindak_lanjut]
        f.input :tindak_lanjut
        f.input :status_tindak_lanjut, :as => :select, :collection => ["Tindak Lanjut", "Proses"] 
    
        f.actions do
          f.action :submit, :label => "Simpan" 
        end
       
      else
      
        f.buttons
      end
            
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
