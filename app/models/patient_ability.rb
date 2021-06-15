class PatientAbility
  include CanCan::Ability

  def initialize(patient)
    can :manage, Patient, id: patient.id if patient.present?
    can :read, Doctor
  end
end
