ActiveAdmin.register Doctor do
  index do
    selectable_column
    id_column
    column :photo do |doctor|
      photo_or_placeholder doctor, 50, 50
    end
    column :first_name
    column :last_name
    column :patronymic
    column :category do |doctor|
      doctor.category.title
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
      row :category
      row :email
      row :phone_number do |doctor|
        number_to_phone(doctor.phone_number, country_code: 380)
      end
      row :photo do |doctor|
        photo_or_placeholder doctor, 200, 200
      end
    end
  end

  filter :first_name
  filter :last_name
  filter :patronymic
  filter :email
  filter :phone_number
  filter :category do
    doctor.category.title
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :patronymic
      f.input :email
      f.input :phone_number
      f.input :category
      f.input :password
      f.input :password_confirmation
      f.input :photo, as: :file
    end
    f.actions
  end

  controller do
    def update
      %w[password password_confirmation].each { |p| params[:doctor].delete(p) } if params[:doctor][:password].blank?

      super
    end

    def permitted_params
      # To fix 'Unpermitted parameters: :authenticity_token, :commit'
      # see: https://github.com/activeadmin/activeadmin/issues/2595
      params.permit :authenticity_token, :commit,
                    doctor: %i[first_name last_name patronymic category_id photo email
                               phone_number password password_confirmation]
    end
  end

end
