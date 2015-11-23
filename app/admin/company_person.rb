ActiveAdmin.register CompanyPerson do
  menu parent: 'Connections', label: 'Person <~> Company'
  filter :person
  filter :company
  permit_params :company_id, :person_id, :owner, :approved
  active_admin_importable

  index do
    column :id
    column :person
    column :company
    column :approved
    column :owner
    column :created_at
    column :updated_at
    actions
  end

  member_action :approve, method: :put do
    cp = CompanyPerson.find(params[:id])
    cp.update_attribute(:approved, true)
    flash[:notice] = "Connection: '#{cp.person.name} <~> #{cp.company.name}' has been approved!."
    redirect_to admin_root_path
  end
end
