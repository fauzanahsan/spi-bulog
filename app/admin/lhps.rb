ActiveAdmin.register Lhp do
  menu :label => "LHP", :if => proc{ can?(:manage, Lhp) }
  controller.authorize_resource
  
  index do
    column("Kode LHP", :id)
    column("Kode PKPT"){ |lhp| lhp.work_plan.pkpt.id }
    column("Kode Rencana Kerja", :work_plan_id)
    column("Status", :status)
    column("Tanggal Awal"){ |wp| wp.tanggal_awal.strftime("%d %B %Y") } 
    column("Tanggal Akhir"){ |wp| wp.tanggal_akhir.strftime("%d %B %Y") } 
    default_actions
  end
  
  form do |f|
    if params[:work_plan_id] 
      work_plan = WorkPlan.find(params[:work_plan_id])
      f.inputs do  
        f.input :work_plan_id_mock, :label => "Kode Rencana Kerja", :input_html => { :value => work_plan.id, :disabled => true }
        f.input :pkpt_id_mock, :label => "Kode PKPT", :input_html => { :value => work_plan.pkpt.id, :disabled => true }
        f.input :periode_mock, :label => "Periode/Tahun", :input_html => { :value => work_plan.pkpt.periode, :disabled => true }
        f.input :tanggal_awal, :label => "Waktu Pemeriksaan", :as => :datepicker
        f.input :tanggal_akhir, :label => "Sampai Dengan", :as => :datepicker
      end  
      
      if work_plan.team
        leader = AdminUser.find(work_plan.team.leader_id) 
        f.inputs "Tim Pengawas" do       
          f.input :leader_id_mock, :label => "Ketua Tim", :input_html => { :value => leader.fullname, :disabled => true }
          # work_plan.team.admin_users.each do |member|
          #             f.input :admin_users_mock, :label => "Anggota", :input_html => { :value => member.fullname, :disabled => true }
          #           end
          # table_for work_plan.team.admin_users do
          #             f.input("Anggota") { |member| member.fullname}
          #           end
        end
      end
      
      f.inputs do    
        f.input :maksud_tujuan, :label => "Maksud dan Tujuan"
        f.input :program_pemeriksaan, :label => "Program Pemeriksaan"   
        f.input :work_plan_id, :as => :hidden, :input_html => { :value => work_plan.id } 
        f.input :entity_id, :as => :hidden, :input_html => { :value => work_plan.pkpt.entity.id }   
      end                                                     
      f.buttons 
    end                      
  end
  
  
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
      

      if lhp.work_plan.team
        row 'Ketua Tim' do
          AdminUser.find(lhp.work_plan.team.leader_id).fullname
          # table_for pkpt.work_plans do
          #    column("Anggota") { |wp| link_to("#{wp.id}", admin_work_plan_path(wp.id)) } 
          #  end
        end
        
        # row '' do
        #           table_for lhp.work_plan.team.admin_users do
        #              column("Anggota") { |u| u.fullname } 
        #            end
        #         end
      end
      
      row 'Maksud dan Tujuan' do
        lhp.maksud_tujuan
      end
      
      row 'Program Pemeriksaan' do
        lhp.program_pemeriksaan
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
      
      row ' ' do
        link_to("Tambah Hasil Pemeriksaan", new_admin_examination_path(:lhp => lhp.id), :method => :get, :class => "button") + "   " + 
        link_to("Kirim LHP", send_report_admin_lhp_path(:id => lhp.id), :method => :put, :class => "button")
      end
 
    end
    
  end
  
  member_action :send_report, :method => :put do
    lhp = Lhp.find(params[:id])
    lhp.dikirim
    flash[:notice] = "Success Sent"
    redirect_to admin_pkpts_path 
  end
  
end
