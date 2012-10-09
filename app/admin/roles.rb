ActiveAdmin.register Role do
  menu :label => "Jabatan"
  controller.authorize_resource
end
