class BaseSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  protected

  def ldate(date)
    if date
      date.strftime('%B %-d at %l:%M%P')
    end
  end
end
