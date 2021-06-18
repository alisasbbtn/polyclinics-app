ActiveAdmin.register Appointment do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :doctor
    column :patient
    column :datetime
    column :active
    column :recommendations
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :doctor
      row :patient
      row :datetime
      row :active
      row :recommendations
      row :created_at
    end
  end

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
