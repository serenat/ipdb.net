ActiveAdmin.register CompanyPodcast do
  menu parent: 'Connections', label: 'Podcast <~> Company'
  filter :company
  permit_params :company_id, :podcast_id, :approved
  active_admin_importable

  index do
    column :id
    column :podcast
    column :company
    column :approved
    column :created_at
    column :updated_at
    actions
  end

  member_action :approve, method: :put do
    cp = CompanyPodcast.find(params[:id])
    cp.update_attribute(:approved, true)
    flash[:notice] = "Connection: '#{cp.podcast.name} <~> #{cp.company.name}' has been approved!."
    redirect_to admin_root_path
  end
end
