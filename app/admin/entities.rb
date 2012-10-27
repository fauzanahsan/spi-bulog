ActiveAdmin.register Entity do
  menu :label => "Entitas"
  controller.authorize_resource
  
  form do |f|
    f.inputs do  
      f.input :kode, :label => "Kode Entitas"
      f.input :entitas, :label => "Nama Entitas"
      f.input :wilayah, :label => "Kode Wilayah", :as => :select, :collection => [1,2,3,4]
      f.input :alamat
      f.input :phone, :label => "No Telepon"
      f.input :fax, :label => "No Fax"
      f.input :kota
      f.input :kecamatan
      f.input :kabupaten
      f.input :provinsi
      f.input :kepala_entitas #, :as => :select, :collection => Hash[AdminUser.all.map{|a| [a.fullname,a.id]}] #.with_role("Campaign Officer")
      f.input :keterangan
      
    end
    f.buttons 
  end
  
end
