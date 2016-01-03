module ApplicationHelper
  def current_person
    current_user && current_user.person
  end

  def nav_elem(path)
    class_name = current_page?(path) ? 'active' : ''
    content_tag(:li, :class => class_name) do
      yield
    end
  end

  def flash_msg(name, msg)
    class_name = (name == 'alert') ? 'alert-danger' : 'alert-info'
    content_tag(:div, msg, class: ['alert', 'flash-msg', class_name])
  end
end
