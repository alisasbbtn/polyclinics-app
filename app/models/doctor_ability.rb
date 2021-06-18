class DoctorAbility
  include CanCan::Ability

  def initialize(doctor)
    can :read, Doctor

    if doctor.present?
      can :show, Appointment, doctor_id: doctor.id
      can :update, Appointment, doctor_id: doctor.id

      can :show, Patient do |patient|
        patient.of?(doctor)
      end
    end
  end
end
