ActiveAdmin.register Recapitulation do
  menu :label => "Rekapitulasi PKPT", :if => proc{ can?(:manage, Recapitulation) }
  controller.authorize_resource
  
  form :partial => "form"
  
end
