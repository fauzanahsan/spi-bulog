ActiveAdmin.register WorkPlan do
  menu :parent => "Rencana Kerja", :label => "Buat Rencana Kerja"
  controller.authorize_resource
  
end
