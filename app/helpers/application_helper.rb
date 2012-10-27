module ApplicationHelper
  
  def manage_pkpt?(current_admin_user, pkpt)
    current_admin_user.has_role? "Korwaswil" && current_admin_user.own_pkpt.id == pkpt.id
  end
  
end
