ActiveAdmin.register User  do
  active_admin_importable
  controller do
    def permitted_params
      params.permit :utf8, :_method, :authenticity_token, :commit, :id,
                user: [:id, :person_id, :email, :description, :password, :password_confirmation, :education, :work, :about, :linkedin, :instagram, :pinterest, :twitter, :facebook, :membership, :imdb ]
    end
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  index do
    column :email
    column :person
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :person
      f.input :password
      f.input :password_confirmation
      f.input :imdb
      f.input :membership, :as => :select, :collection => [['Podcast Fan Plus'], ['PodcasterBasic'], ['PodcasterPRO']]
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
