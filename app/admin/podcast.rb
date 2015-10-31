ActiveAdmin.register Podcast do
	filter :name
  filter :awards

  permit_params :description, :name, :image_file_name,:image_url, :episodes_url, :episodes_count,
    :user_id, :explicit, :category, :approved,:user_approved, :itunes_id, :video, :start_date,
    nominations_attributes: [:id, :award_id, :name, :year, :_destroy]

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
    column :score
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :explicit
      row :awards do |podcast|
        podcast.awards.map(&:name).join(', ')
      end
      row :score
      row :approved
      row :episodes_url
      row :episodes_count
      row :user
      row :user_approved
      row :guest
      row :cohost
      row :ppff
      row :hideplayer
      row :itunes
      row :video
      row :start_date
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Podcast Details" do
      f.input :name
      f.input :explicit, :label => "Explict?"
      f.input :episodes_url
      f.input :episodes_count
      f.input :description
      f.input :itunes_id
      f.input :category, :as => :select, :collection => categories_list
      f.input :approved
      f.input :user_approved
      f.input :video
      f.input :start_date
    end

    f.inputs do
      f.has_many :nominations, heading: 'Nominations', allow_destroy: true, new_record: true do |a|
        a.input :award
        a.input :name
        a.input :year
      end
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

