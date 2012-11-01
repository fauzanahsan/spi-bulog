ActiveAdmin.register Pkpt do
  menu :label => "PKPT", :if => proc{ can?(:manage, Pkpt) }
  controller.authorize_resource
  #actions :all, :except => [:destroy]
  
  filter :id, :label => "Kode PKPT"
  filter :periode, :as => :select, :collection => ['2012','2013','2014']  
  filter :status, :as => :select, :collection => ['Diinput','Disetujui','Dikirim','Dikembalikan']  
  filter :wilayah 
  filter :created_at 
  
  form do |f| 
    f.inputs do 
      f.input :entity_mock, :label => "Entitas", :input_html => { :value => current_admin_user.entity.entitas, :disabled => true }                           
      f.input :periode, :as => :select, :collection => ['2012','2013','2014']    
      if !f.object.new_record?
        f.input :status, :as => :select, :collection => Pkpt::DOC_STATUS
      end
      f.input :notes, :label => "Catatan" #, :input_html => { :disabled=>true }
      f.input :entity_id, :as => :hidden, :input_html => { :value => current_admin_user.entity.id }   
      f.input :wilayah, :as => :hidden, :input_html => { :value => current_admin_user.entity.provinsi }    
            
    end

    f.buttons                         
  end
  
  index do
    column("Kode PKPT", :id)
    column("Status", :status)
    column("Wilayah", :wilayah)
    column("Entitas"){ |pkpt| pkpt.entity.kota } 
    column("Periode/Tahun", :periode)
    column("Catatan", :notes)
    column(:created_at)
    default_actions
  end
  
  show do |pkpt|
    attributes_table do
      if pkpt.status == 'Disetujui' && current_admin_user.entity.id == pkpt.entity.id
        row 'Periode' do
          pkpt.periode
        end
        row 'Entitas' do
          pkpt.entity.entitas
        end
        row 'Program Kerja' do
          table_for pkpt.work_plans do
            column("Kode") { |wp| link_to("#{wp.id}", admin_work_plan_path(wp.id)) } 
            column("Keterangan", :work_plan_details)
            column("Jumlah LHP") { |wp| wp.lhps.count }
            
            if current_admin_user.own_pkpt.id == pkpt.id && (current_admin_user.has_role?("Korwaswil") || current_admin_user.has_role?("Kabidwas"))  
              column("Proses") { |wp| link_to("Buat LHP", new_admin_lhp_path(:work_plan_id => wp.id))  }  
            end
            
          end
    
        end
      else
        row 'Kode PKPT' do
          pkpt.id
        end
     
        row 'Periode' do
          pkpt.periode
        end
    
        row 'Entitas' do
          pkpt.entity.entitas
        end
    
        row 'Catatan' do
          raw pkpt.notes.gsub(/\n/, '<br/>')
        end
    
        row 'Status Dokumen' do
          pkpt.status
        end
    
        row 'Tanggal' do
          pkpt.updated_at.strftime("%H:%M %d %B %Y")
        end
    
        row 'Catatan Pengembalian' do
          pkpt.catatan_pengembalian
        end
    
        row 'Rencana Kerja' do
    
          if current_admin_user.has_role? "Staff"
            @work_plans = pkpt.work_plans.where(:created_by_id => current_admin_user.id)
          else
            @work_plans = pkpt.work_plans
          end
          #table_for pkpt.work_plans.where(:created_by_id => current_admin_user.id) do
          table_for @work_plans do
            column("Kode") { |wp| link_to("#{wp.id}", admin_work_plan_path(wp.id)) } 
            column("Deskripsi", :work_plan_details)
            column("Kategori") { |wp| wp.work_plan_category.name }
            column("Status", :status)
            column("Tanggal") { |wp| wp.created_at.strftime("%d %B %Y") }
        
            if (current_admin_user.has_role?("Korwaswil") || current_admin_user.has_role?("Kabidwas")) && current_admin_user.own_pkpt.id == pkpt.id
              column("Proses") { |wp| link_to("Kembalikan", edit_admin_work_plan_path(wp.id, :dikembalikan => true)) }  
            end
        
            if current_admin_user.has_role? "Staff"
              column("Proses") { |wp| link_to("Ubah", edit_admin_work_plan_path(wp.id, :pkpt => pkpt.id))   }
            end
        
          end
    
        end
    
        if current_admin_user.has_role? "Staff"
          row ' ' do
            link_to("Tambah Rencana Kerja", new_admin_work_plan_path(:pkpt => pkpt.id), :method => :get, :class => "button") + " " +
            link_to("Kirim Rencana Kerja", wp_kirim_admin_pkpt_path(:pkpt => pkpt.id), :method => :put, :class => "button")
          end
        end
    
        if current_admin_user.has_role? "Kepala SPI"
          row ' ' do
            link_to("Setujui PKPT", approve_admin_pkpt_path(:id => pkpt.id), :method => :put, :class => "button")
          end
        end
    
        if (current_admin_user.has_role?("Korwaswil") || current_admin_user.has_role?("Kabidwas"))  && current_admin_user.entity.pkpt_aktif && current_admin_user.entity.pkpt_aktif.id == pkpt.id
          row ' ' do
            link_to("Kirim PKPT", kirim_admin_pkpt_path(:id => pkpt.id), :method => :put, :class => "button") 
          end
        end
        
      end
      
    end
    
  end
  
  member_action :approve, :method => :put do
    pkpt = Pkpt.find(params[:id])
    pkpt.disetujui
    flash[:notice] = "Success Approved"
    redirect_to admin_pkpts_path 
  end
  
  member_action :kirim, :method => :put do
    pkpt = Pkpt.find(params[:id])
    pkpt.dikirim
    flash[:notice] = "Success Sent"
    redirect_to admin_pkpts_path 
  end
  
  member_action :work_plan_return, :method => :put do
    work_plan = WorkPlan.find(params[:id])
    work_plan.dikembalikan
    flash[:notice] = "Success Returned"
    redirect_to admin_pkpt_path(params[:pkpt_id])
  end
  
  member_action :wp_kirim, :method => :put do
    WorkPlan.find(:all, :conditions => ['pkpt_id = ? and created_by_id = ?', params[:pkpt], current_admin_user.id]).each do |obj|
      obj.update_attributes(:status => 'Dikirim')
    end
    flash[:notice] = "Success Sent"
    redirect_to admin_pkpt_path(params[:pkpt])
  end
  
  member_action :lhp_overview, :method => :get do
    @pkpt = Pkpt.find(params[:id])
    render :partial => "proses_lhp", :locals => {:pkpt => @pkpt }
  end
  
end
