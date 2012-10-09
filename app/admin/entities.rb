ActiveAdmin.register Entity do
  menu :label => "Entitas"
  controller.authorize_resource
end
