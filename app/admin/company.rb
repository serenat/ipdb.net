ActiveAdmin.register Company do
  permit_params :name, :city, :state, :country, :url, :approved, :image

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
    bool_column :approved
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :city
      row :state
      row :country
      row :url
      bool_row :approved
      row :image do
        image_tag company.image.url(:thumb)
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Company Details', multipart: true do
      f.input :name
      f.input :city
      f.input :country, priority_countries: ['US', 'AU', 'CA'], input_html: { class: 'bth-countries', data: {country: f.object.country}}
      f.input :state, as: :select, input_html: { class: 'bfh-states', data: {country: 'company_country', state: f.object.state}}
      f.input :url
      f.input :approved
      f.input :image, as: :file, hint: image_tag(f.object.image.url(:thumb))
    end
    f.actions
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
