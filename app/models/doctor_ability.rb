class DoctorAbility
  include CanCan::Ability

  def initialize(doctor)
    can :read, Doctor

    if doctor.present?
      can :update, Appointment, doctor_id: doctor.id
      can :read, Patient do |patient|
        patient.of?(doctor)
      end
    end
  end
end
