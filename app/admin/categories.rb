ActiveAdmin.register Category do
  index do
    selectable_column
    id_column
    column :title
    actions
  end

  filter :title

  form do |f|
    f.inputs do
      f.input :title
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit category: [:title]
    end
  end
end
