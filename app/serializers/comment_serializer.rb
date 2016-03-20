class CommentSerializer < BaseSerializer
  attributes :id, :content, :created_at, :created_at_formated, :user_id,
    :user_name, :user_profile_image, :user_profile_url

  def user_id
    user.id
  end

  def user_name
    user.person.name
  end

  def user_profile_url
    person_path(user.person)
  end

  def user_profile_image
    user.profile_image
  end

  def created_at_formated
    ldate object.created_at
  end

  def user
    @user ||= object.user
  end

end
