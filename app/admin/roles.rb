ActiveAdmin.register Role do
  menu :label => "Jabatan", :if => proc{ can?(:manage, Role) }
  controller.authorize_resource
end
