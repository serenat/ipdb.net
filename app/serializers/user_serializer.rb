class UserSerializer < BaseSerializer
  attributes :id, :name, :profile_image, :profile_url, :membership

  def profile_url
    person_path(object.person)
  end

  def name
    object.person.name
  end
end
