ActiveAdmin.register Pkpt do
  menu :label => "PKPT"
  controller.authorize_resource
  
  form do |f| 
    f.inputs do 
      f.input :wilayah_mock, :label => "Wilayah", :input_html => { :value => current_admin_user.entity.provinsi, :disabled => true } 
      f.input :entity_mock, :label => "Entitas", :input_html => { :value => current_admin_user.entity.kota, :disabled => true }                           
      f.input :periode, :as => :select, :collection => ['2012','2013','2014']    
      if !f.object.new_record?
        f.input :status, :as => :select, :collection => Pkpt::DOC_STATUS
      end
      f.input :notes, :label => "Catatan" #, :input_html => { :disabled=>true }
      f.input :entity_id, :as => :hidden, :input_html => { :value => current_admin_user.entity.id }   
      f.input :wilayah, :as => :hidden, :input_html => { :value => current_admin_user.entity.provinsi }    
      
      # if !f.object.new_record?
      #       
      #         f.has_many :work_plans do |wp|
      #           app_f.inputs "Rencana Kerja" do
      #             if !app_f.object.nil?
      #               # show the destroy checkbox only if it is an existing appointment
      #               # else, there's already dynamic JS to add / remove new appointments
      #               app_f.input :_destroy, :as => :boolean, :label => "Destroy?"
      #             end
      # 
      #             app_f.input :description # it should automatically generate a drop-down select to choose from your existing patients
      #             app_f.input :staff_input
      #           end
      #         end
      #       
      #       end
      
      
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
      row 'Kode PKPT' do
        pkpt.id
      end
      
      row 'Wilayah' do
        pkpt.wilayah
      end
      
      row 'Entitas' do
        pkpt.entity.kota
      end
      
      row 'Periode' do
        pkpt.periode
      end
      
      row 'Catatan' do
        pkpt.notes
      end
      
      row 'Rencana Kerja' do
      
        table_for pkpt.work_plans do
          column("Kode", :id) 
          column("Deskripsi", :description)
          column("Staff Input", :staff_input)
          column("Kategori") { |wp| wp.work_plan_category.name }
          column("Status", :status)
          column("Tanggal") { |wp| wp.tanggal_proses.strftime("%d %B %Y") }
          column("Proses") { |wp| link_to("Kembalikan", approve_admin_pkpt_path, :method => :put) }  
        end
      
      end
      
      row ' ' do
        link_to("Tambah Rencana Kerja", new_admin_work_plan_path(:pkpt => pkpt.id), :method => :get, :class => "button") + "   " + 
        link_to("Setujui PKPT", approve_admin_pkpt_path(:pkpt_id => pkpt.id), :method => :put, :class => "button")
      end
      
    end
    
  end
  
  member_action :approve, :method => :put do
    
    flash[:notice] = "Success Approved"
    redirect_to admin_pkpts_path 
  end
  
end
