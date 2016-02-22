module PagesHelper
	def resource_name
	  :user
	end

	def resource
	  @resource ||= User.new
	end

	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end

  def ldate(datetime, hash = {})
    if datetime
      l(datetime, hash)
    end
  end
end
