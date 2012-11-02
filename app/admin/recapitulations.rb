ActiveAdmin.register Recapitulation do
  menu :label => "Rekapitulasi PKPT", :if => proc{ can?(:manage, Recapitulation) }
  controller.authorize_resource
  
  form :partial => "form"
  
  member_action :rekap, :method => :put do
    rekap = Recapitulation.find(params[:id])
    rekap.direkap
    flash[:notice] = "Sukses Rekap"
    redirect_to admin_recapitulations_path 
  end
  
end
