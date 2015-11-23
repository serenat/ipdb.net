module ApplicationHelper
  def current_person
    current_user && current_user.person
  end
end
