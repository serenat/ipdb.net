ActiveAdmin.register PersonPodcast, :as => "Connections" do
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
    f.inputs "Podcast Details" do
      f.input :podcast_id
      f.input :person_id
      f.input :position, as: :select, collection: connection_positions
      f.input :doc_url
      f.input :approved
    end
    f.actions
  end



  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
end

