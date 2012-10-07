class AdminAbility
  include CanCan::Ability

  def initialize(admin_user)
    admin_user ||= AdminUser.new

    if admin_user.has_role? :admin
      can :manage, :all
    end
    
  end
end