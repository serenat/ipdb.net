ActiveAdmin.register UserPodcast, :as => "Connections" do
	filter :user
  permit_params :position, :name ,:podcast_id, :description, :name, :image_file_name,:image_url, :episodes, :user_id, :guest_id, :cohost_id, :pcaward, :pcaward2, :pcaward3, :explicit,:category, :ppff, :approved
  active_admin_importable
  
     batch_action :flag do |selection|
      Post.find(selection).each { |p| p.flag! }
      redirect_to collection_path, :notice => "Posts flagged!"
    end
  
  index do
   selectable_column
    column :podcast
    column :position
    column :user
    column :id
 actions
end

  form do |f|
    f.inputs "Podcast Details" do
      f.input :podcast_id
      f.input :user_id
      f.input :position, :as => :select, :collection => [['Host'], ['Co-Host'], ['Guest'],['Art Work'], ['Music'], ['Sound Engineer'], ['Performer']]
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

