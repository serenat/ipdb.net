ActiveAdmin.register Podcast do
  permit_params :description, :name, :image_file_name,:image_url, :episodes_url, :feed_url, :episodes_count,
    :user_id, :explicit, :category, :approved,:user_approved, :itunes_id, :video, :start_date, :image,
    nominations_attributes: [:id, :award_id, :name, :year, :_destroy]

  active_admin_importable

  filter :name
  filter :awards
  filter :category
  filter :people
  filter :companies
  filter :episodes_url
  filter :explicit
  filter :video
  filter :approved
  filter :start_date

  batch_action :flag do |selection|
    Post.find(selection).each { |p| p.flag! }
    redirect_to collection_path, :notice => "Posts flagged!"
  end

  index do
    text_node '* A - Approved, E - Explicit, V - Video'
    selectable_column
    column :name do |podcast|
      "<div style='min-width:180px'>#{podcast.name}</div>".html_safe
    end
    list_column :awards do |podcast|
      podcast.awards.map do |award|
        link_to award.name, admin_award_path(award), style: "white-space:nowrap;"
      end
    end
    column :category
    list_column :people do |podcast|
      podcast.people.map do |person|
        link_to person.name, admin_person_path(person), style: "white-space:nowrap;"
      end
    end
    list_column :companies do |podcast|
      podcast.companies.map do |company|
        link_to company.name, admin_company_path(company), style: "white-space:nowrap;"
      end
    end
    bool_column 'A', :approved
    bool_column 'E', :explicit
    bool_column 'V', :video
    column :start_date

    actions do |podcast|
      link_to "Edit(new tab)", edit_admin_podcast_path(podcast), class: "member_link", target: '_blank'
    end
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
      row 'episodes_url (itunes_url)' do |podcast|
        podcast.episodes_url
      end
      row 'itunes id' do |podcast|
        podcast.itunes_id
      end
      row :feed_url
      row :episodes_count
      row :user
      row :user_approved
      row :guest
      row :cohost
      row :ppff
      row :hideplayer
      row :video
      row :start_date
      row :image do |podcast|
        image_tag(podcast.image.url(:thumb))
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Podcast Details", multipart: true do
      f.input :name
      f.input :explicit, :label => "Explict?"
      f.input :episodes_url, label: 'Episodes url (Itunes url)'
      f.input :itunes_id, label: 'Itunes id'
      f.input :feed_url
      f.input :episodes_count
      f.input :description
      f.input :category, :as => :select, :collection => categories_list
      f.input :approved
      f.input :user_approved
      f.input :video
      f.input :start_date
      f.input :image, as: :file, hint: image_tag(f.object.image.url(:thumb))
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

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
