ActiveAdmin.register Lhp do
  #config.clear_sidebar_sections!
  menu :label => "LHP", :if => proc{ can?(:manage, Lhp) }
  controller.authorize_resource
  
  filter :entity, :label => "Entitas", :collection => Hash[Entity.all.map{|e| [e.entitas,e.id]}]
  filter :keterangan
  filter :tanggal_awal
  filter :tanggal_akhir
  filter :created_by
  filter :updated_by
  filter :accepted_by
  filter :created_at
  filter :updated_at
  filter :accepted_at
  filter :catatan_pengembalian
  
  
  index do
    if current_admin_user.has_role?("Ketua Tim") || current_admin_user.has_role?("Anggota Tim")
      column("ID LHP"){ |lhp| 
        if lhp.status == "Ditolak" || lhp.status == "Diinput"
          link_to("#{lhp.id}", edit_admin_lhp_path(lhp.id, :work_plan_id => lhp.work_plan.id))
        elsif lhp.status == "Disetujui"
          link_to("#{lhp.id}", admin_lhp_path(lhp.id))
        elsif lhp.status == "Dikirim"
          link_to("#{lhp.id}", edit_admin_lhp_path(lhp.id, :work_plan_id => lhp.work_plan.id))
        end
      }
      column("Keterangan", :keterangan)
      column("Jumlah Temuan"){ |lhp| lhp.examinations.count }
      column("Status", :status)
    elsif current_admin_user.has_role?("Korwaswil") || current_admin_user.has_role?("Kabidwas") || current_admin_user.has_role?("Kepala SPI") 
      column("ID LHP"){ |lhp| 
          link_to("#{lhp.id}", edit_admin_lhp_path(lhp.id, :work_plan_id => lhp.work_plan.id))
      }
      column("Entitas"){|lhp| lhp.work_plan.pkpt.entity.entitas }
      column("Keterangan", :keterangan)
      column("Jumlah Temuan"){ |lhp| lhp.examinations.count }
      column("Status", :status)
    else
      column("Kode LHP", :id)
      column("Kode PKPT"){ |lhp| lhp.work_plan.pkpt.id }
      column("Kode Rencana Kerja", :work_plan_id)
      column("Status", :status)
      column("Tanggal Awal"){ |lhp| lhp.tanggal_awal.strftime("%d %B %Y") } 
      column("Tanggal Akhir"){ |lhp| lhp.tanggal_akhir.strftime("%d %B %Y") } 
      default_actions
    end
  end
  
  form :partial => "form"
  
  show do |lhp|
    attributes_table do
      row 'Kode LHP' do
        lhp.id
      end
      
      row 'Kode Rencana Kerja' do
        lhp.work_plan.id
      end
      
      row 'Kode PKPT' do
        lhp.work_plan.pkpt.id
      end
      
      row 'Periode' do
        lhp.work_plan.pkpt.periode
      end
      
      row 'Keterangan' do
        lhp.keterangan
      end
      
      row 'Hasil Pemeriksaan' do
      
        table_for lhp.examinations do
          column("ID") { |examination| link_to("#{examination.id}", admin_examination_path(examination.id)) } 
          column("Uraian", :uraian)
          column("Rekomendasi", :rekomendasi)
          column("Tanggapan", :tanggapan)
          column("Status", :status)
          column("Tanggal") { |examination| examination.created_at.strftime("%d %B %Y") }
          column("Proses") { |examination| 
                              if lhp.status == 'Disetujui'
                                link_to("Tindak Lanjut", edit_admin_examination_path(examination.id, :tindak_lanjut => true))
                              else
                                link_to("Ubah", edit_admin_examination_path(examination.id))  + " " +
                                link_to("Kembalikan", edit_admin_examination_path(examination.id, :dikembalikan => true))
                              end
          }  
        end
      
      end
      
      if current_admin_user.has_role?("Anggota Tim") && (lhp.status == "Diinput" || lhp.status == "Dikembalikan")
        row ' ' do
          link_to("Tambah Hasil Pemeriksaan", new_admin_examination_path(:lhp => lhp.id), :method => :get, :class => "button") + "   " + 
          link_to("Kirim LHP", send_report_admin_lhp_path(:id => lhp.id), :method => :put, :class => "button")
        end
      end
 
    end
    
  end
  
  controller do
    def index
      index! do |format|
        
        ### KORWASWIL
        if current_admin_user.has_role?("Korwaswil")
          @lhp_ids = []
          @lhps = []
          Lhp.all.each do |lhp|
            @lhp_ids << lhp.id if lhp.work_plan.pkpt.entity.wilayah == current_admin_user.entity.wilayah
          end
        
          @lhps = Lhp.where("id IN (?)", @lhp_ids).page(params[:page])
          
        ### KABIDWAS
        elsif current_admin_user.has_role?("Kabidwas")
          @lhps = Lhp.where(:entity_id => current_admin_user.entity.id).page(params[:page])
        
        ### KETUA TIM
        elsif current_admin_user.has_role?("Ketua Tim")
          @lhp_ids = []
          @lhps = []
          
          Team.all.each do |tim|
            @lhp_ids << tim.lhp_id if tim.leader_id == current_admin_user.id
          end
          @lhps = Lhp.where("id IN (?)", @lhp_ids).page(params[:page])
          
        ### ANGGOTA TIM
        elsif current_admin_user.has_role?("Anggota Tim")
          @lhps = Lhp.where("id IN (?)", current_admin_user.teams.map(&:lhp_id)).page(params[:page])
          
        else
          @lhps = Lhp.where(:entity_id => current_admin_user.entity.id).page(params[:page])
        end
        
        format.html
        
      end
    end
  end
  
  member_action :send_report, :method => :put do
    lhp = Lhp.find(params[:id])
    lhp.dikirim
    flash[:notice] = "Success Sent"
    redirect_to admin_pkpts_path 
  end
  
  member_action :send_lhp, :method => :put do
    lhp = Lhp.find(params[:id])
    lhp.dikirim
    flash[:notice] = "Success Sent"
    redirect_to admin_lhps_path 
  end
  
  member_action :accept_lhp, :method => :put do
    lhp = Lhp.find(params[:id])
    lhp.disetujui
    flash[:notice] = "Success Accepted"
    redirect_to admin_lhps_path 
  end
  
  member_action :send_back_lhp, :method => :put do
    lhp = Lhp.find(params[:id])
    lhp.dikembalikan
    flash[:notice] = "Success Sent Back"
    redirect_to admin_lhps_path 
  end

  

end
