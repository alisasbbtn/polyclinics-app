ActiveAdmin.register Patient do
  index do
    selectable_column
    id_column
    column :photo do |patient|
      photo_or_placeholder patient, 50, 50
    end
    column :first_name
    column :last_name
    column :patronymic
    column :birth_date
    column :gender do |patient|
      t("gender.#{patient.gender}") if patient.gender?
    end
    column :email
    column :phone_number do |doctor|
      number_to_phone(doctor.phone_number, country_code: 380)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :patronymic
      row :birth_date
      row :gender do |patient|
        t("gender.#{patient.gender}") if patient.gender?
      end
      row :email
      row :phone_number do |patient|
        number_to_phone(patient.phone_number, country_code: 380)
      end
      row :photo do |patient|
        photo_or_placeholder patient, 200, 200
      end
    end
  end

  filter :first_name
  filter :last_name
  filter :patronymic
  filter :birth_date
  filter :gender, as: :select, collection: (Patient.genders.collect { |k, v| [I18n.t("gender.#{k}"), v] })
  filter :email
  filter :phone_number

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :patronymic
      f.input :birth_date, as: :date_select, start_year: 1900
      f.input :gender, as: :select, collection: Patient.genders.keys.collect { |k| [I18n.t("gender.#{k}"), k] }
      f.input :email
      f.input :phone_number
      f.input :password
      f.input :password_confirmation
      f.input :photo, as: :file
    end
    f.actions
  end

  controller do
    def update
      %w[password password_confirmation].each { |p| params[:patient].delete(p) } if params[:patient][:password].blank?

      super
    end

    def permitted_params
      # To fix 'Unpermitted parameters: :authenticity_token, :commit'
      # see: https://github.com/activeadmin/activeadmin/issues/2595
      params.permit :authenticity_token, :commit,
                    patient: %i[first_name last_name patronymic photo birth_date gender
                                email phone_number password password_confirmation]
    end
  end
end
