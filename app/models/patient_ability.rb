class PatientAbility
  include CanCan::Ability

  def initialize(patient)
    if patient.present?
      can :manage, Patient, id: patient.id
      can :manage, Appointment, patient_id: patient.id
      cannot :edit, Appointment
      can :create, Appointment
    end
    can :read, Doctor
  end
end
