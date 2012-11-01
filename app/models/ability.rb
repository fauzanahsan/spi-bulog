class Ability
  include CanCan::Ability

  def initialize(admin_user)
    admin_user ||= AdminUser.new

    if admin_user.has_role? "Admin"
      can :manage, AdminUser
      can :manage, Entity
    end
    
    if admin_user.has_role? "Korwaswil"
      can :manage, Pkpt
      can :manage, Lhp
      can :manage, WorkPlan
    end
    
    if admin_user.has_role? "Direksi"
      can :manage, Pkpt
    end
    
    if admin_user.has_role? "Kepala SPI"
      can :manage, Pkpt
      can :manage, Lhp
      can :manage, Recapitulation
    end
    
    if admin_user.has_role? "Kabidwas"
      can :manage, Pkpt
      can :manage, Lhp
      can :manage, WorkPlan
    end
    
    if admin_user.has_role? "Staff"
      can :manage, Pkpt
      can :manage, WorkPlan
    end
    
    if admin_user.has_role? "Staff Tata Usaha"
      can :manage, Recapitulation
    end
    
    if admin_user.has_role? "Ketua Tim"
      can :manage, Lhp
      can :manage, Examination
    end
    
    if admin_user.has_role? "Anggota Tim"
      can :manage, Lhp
      can :manage, Examination
    end
    
  end
end