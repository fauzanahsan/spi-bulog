ActiveAdmin.register WorkPlanCategory do
  menu :label => "Kategori Rencana Kerja", :parent => "Rencana Kerja"
  controller.authorize_resource
  
end
