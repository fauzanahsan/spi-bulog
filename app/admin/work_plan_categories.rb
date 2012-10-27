ActiveAdmin.register WorkPlanCategory do
  menu :label => "Kategori Rencana Kerja", :parent => "Rencana Kerja", :if => proc{ can?(:manage, WorkPlanCategory) }
  controller.authorize_resource
  
end
