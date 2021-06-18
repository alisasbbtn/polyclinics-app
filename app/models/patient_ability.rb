class PatientAbility
  include CanCan::Ability

  def initialize(patient)
    if patient.present?
      can :manage, Patient, id: patient.id
      cannot :index, Patient
      can :manage, Appointment, patient_id: patient.id
      can :create, Appointment
      cannot :edit, Appointment
    end
    can :read, Doctor
  end
end
