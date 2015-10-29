class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :profile_image, :profile_path

  def profile_path
    user_path(object) if object.id
  end
end
