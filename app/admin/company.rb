ActiveAdmin.register Company do
  permit_params :name, :city, :state, :country, :url, :approved

  filter :name
  filter :people
  filter :city
  filter :state
  filter :country
  filter :url
  filter :approved
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :city
    column :state
    column :country
    column :url
    column :approved
    column :created_at
    actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  member_action :approve, method: :put do
    company = Company.friendly.find(params[:id])
    company.update_attribute(:approved, true)
    flash[:notice] = "Company: '#{company.name}' has been approved!."
    redirect_to admin_root_path
  end
end
