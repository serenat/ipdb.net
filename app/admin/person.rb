ActiveAdmin.register Person  do
  filter :name
  permit_params :name
  active_admin_importable

  index do
    column :name
    column :user
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.actions
  end
end
