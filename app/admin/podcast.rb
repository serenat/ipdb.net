ActiveAdmin.register Podcast do
	filter :name 
  filter :awards
  permit_params :description, :name, :image_file_name,:image_url, :episodes_url, :user_id, :explicit, :category, :approved,:user_approved, :awards, :itunes_id, :video
  active_admin_importable
  
     batch_action :flag do |selection|
      Post.find(selection).each { |p| p.flag! }
      redirect_to collection_path, :notice => "Posts flagged!"
    end
  
  index do
   selectable_column
    column :name
    column :description
    column :id

 actions
end

  form do |f|
    f.inputs "Podcast Details" do
      f.input :name
      f.input :explicit, :label => "Explict?"
      f.input :episodes_url
      f.input :description
      f.input :itunes_id
      f.input :image_file_name
      f.input :image_url
      f.input :category, :as => :select, :collection =>[["arts"], ["business"], ["comedy"],["education"], ["games & hobbies"], ["government & organizations"],["health"], ["kids & family"],["music"], ["news & politics"], ["religion & spirituality"],["science & medicine"], ["society & culture"],["sports & recreation"], ["technology"],["tv & film"]]
      f.input :awards, :as => :select, :collection =>[["Podcast Award Nominee"],["Podcast Award Winner"],["Stitcher Award Nominee"],["Stitcher Award Winner"],["Parsec Award Nominee"],["Parsec Award Winner"],["IPDb Nominee"],["IPDb Winner"]]
      f.input :approved
      f.input :user_approved
      f.input :video

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

