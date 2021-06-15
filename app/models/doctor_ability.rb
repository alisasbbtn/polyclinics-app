class DoctorAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Doctor
  end
end
