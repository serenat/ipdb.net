ActiveAdmin.register PersonPodcast do
  menu parent: 'Connections', label: 'Person <~> Podcast'
	filter :person
  permit_params :podast_id, :person_id, :position, :doc_url, :approved
  active_admin_importable

    batch_action :flag do |selection|
      Post.find(selection).each { |p| p.flag! }
      redirect_to collection_path, :notice => "Posts flagged!"
    end

  index do
    selectable_column
    column :podcast
    column :person
    column :position
    column :approved
    column :doc_url
    column :id
    actions
  end

  form do |f|
    f.inputs "Person <~> Podcast" do
      f.input :person
      f.input :podcast_id, as: :search_select, url: admin_podcasts_path,
          fields: [:name], display_name: 'name', minimum_input_length: 2
      f.input :position, as: :select, collection: connection_positions
      f.input :doc_url
      f.input :approved
    end
    f.actions
  end

  member_action :approve, method: :put do
    pp = PersonPodcast.find(params[:id])
    pp.update_attribute(:approved, true)
    flash[:notice] = "Connection: '#{pp.person.name} <~> #{pp.podcast.name}' has been approved!."
    redirect_to admin_root_path
  end
end

