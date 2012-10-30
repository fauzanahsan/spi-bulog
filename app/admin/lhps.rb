ActiveAdmin.register Lhp do
  #config.clear_sidebar_sections!
  menu :label => "LHP", :if => proc{ can?(:manage, Lhp) }
  controller.authorize_resource
  
  index do
    if current_admin_user.has_role?("Ketua Tim") || current_admin_user.has_role?("Anggota Tim")
      column("ID LHP"){ |lhp| 
        if lhp.status == "Ditolak" || lhp.status == "Diinput"
          link_to("#{lhp.id}", edit_admin_lhp_path(lhp.id, :work_plan_id => lhp.work_plan.id))
        elsif lhp.status == "Disetujui"
          link_to("#{lhp.id}", admin_lhp_path(lhp.id))
        elsif lhp.status == "Dikirim"
          link_to("#{lhp.id}", edit_admin_lhp_path(lhp.id))
        end
      }
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
  
  # form do |f|
  #     if params[:work_plan_id] 
  #       work_plan = WorkPlan.find(params[:work_plan_id])
  #       f.inputs do
  #         f.input :periode_mock, :label => "Periode/Tahun", :input_html => { :value => work_plan.pkpt.periode, :disabled => true }  
  #         f.input :work_plan_id_mock, :label => "Kode Rencana Kerja", :input_html => { :value => work_plan.id, :disabled => true }
  #         f.input :work_plan_detail_mock, :label => "Rencana Kerja", :input_html => { :value => work_plan.work_plan_details, :disabled => true }
  #         f.input :entity, :label => "Orbrik", :as => :select, :collection => Hash[Entity.all.map{|e| [e.entitas,e.id]}] 
  #         f.input :keterangan
  #         f.input :tanggal_awal, :label => "Waktu Pemeriksaan", :as => :datepicker
  #         f.input :tanggal_akhir, :label => "Sampai Dengan", :as => :datepicker
  #         f.input :work_plan_id, :as => :hidden, :input_html => { :value => params[:work_plan_id] } 
  #       end
  #       
  #       if f.object.new_record?
  #         f.inputs "Tim Pengawas", :for => [:team, f.object.team || Team.new] do |team_form|
  #           team_form.input :leader_id, :label => "Ketua Tim", :as => :select, :collection => Hash[AdminUser.with_role("Ketua Tim").all.map{|e| [e.email,e.id]}]
  #           team_form.input :admin_users, :label => "Anggota", :as => :check_boxes, :collection => Hash[AdminUser.with_role("Anggota Tim").all.map{|e| [e.email,e.id]}]
  #         end
  #       else
  #         f.inputs "Tim Pengawas", :for => [:team, f.object.team || Team.new] do |p|
  #           p.input :leader_id, :label => "Ketua Tim", :as => :select, :collection => Hash[AdminUser.with_role("Ketua Tim").all.map{|e| [e.email,e.id]}], :input_html => { :disabled => true }  
  #           p.input :admin_users, :label => "Anggota", :as => :select, :collection => Hash[p.object.admin_users.with_role("Anggota Tim").all.map{|e| [e.email,e.id]}]
  #         end
  #         f.inputs do
  #           f.input :pendahuluan
  #           f.input :penutup
  #           f.input :status_mock, :input_html => { :value => f.object.status, :disabled => true }  
  #           f.input :updated_at_mock, :label => "Tanggal", :input_html => { :value => f.object.updated_at.strftime("%d %B %Y") , :disabled => true }  
  #           f.input :catatan_pengembalian_mock,  :label => "Catatan Pengembalian", :input_html => { :value => f.object.catatan_pengembalian, :disabled => true }  
  #         end
  # 
  #         f.inputs "Hasil Pemeriksaan" do 
  #           f.has_many :examinations do |p| 
  #              p.input :uraian, :input_html => { :disabled => true }
  #              p.input :rekomendasi,:input_html => { :class => 'autogrow', :rows => 10, :cols => 20, :maxlength => 10  } 
  #              p.input :tanggapan, :input_html => { :disabled => true } 
  #              p.input :status, :input_html => { :disabled => true } 
  #              p.input :created_at, :label => "Tanggal", :input_html => { :disabled => true } 
  #           end 
  #         end
  #          
  #       end
  #                                                       
  #       f.buttons 
  #     end                      
  #   end
  
  
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
          column("Proses") { |examination| #if !wp.returned? 
                                    link_to("Ubah", edit_admin_examination_path(examination.id))  + " " +
                                    link_to("Kembalikan", edit_admin_examination_path(examination.id, :dikembalikan => true))
                                  #end
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
  

end
