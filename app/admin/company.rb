ActiveAdmin.register Company do
  #filter :person
  permit_params :name, :city, :state, :country, :url, :approved

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
