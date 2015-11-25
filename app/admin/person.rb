ActiveAdmin.register Person  do
  permit_params :name
  active_admin_importable

  filter :name
  filter :companies
  filter :created_at
  filter :updated_at

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

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
