ActiveAdmin.register Award do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs "Award Details" do
      f.input :name
    end
    f.actions
  end
end
