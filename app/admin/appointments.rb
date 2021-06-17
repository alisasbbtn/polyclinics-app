ActiveAdmin.register Appointment do
  filter :patient
  filter :doctor
  filter :datetime
  filter :recommendations
  filter :active
  filter :created_at

  controller do
    def permitted_params
      params.permit doctor: %i[doctor_id patient_id datetime active recommendations]
    end
  end
end
