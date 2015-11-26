Paperclip.options[:command_path] = Rails.application.config_for(:utils)['image_magic']

Paperclip.interpolates(:podcast_placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("microphone_#{style}.png")
end

Paperclip.interpolates(:user_placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("user_#{style}.png")
end

Paperclip.interpolates(:company_placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("university_#{style}.png")
end
