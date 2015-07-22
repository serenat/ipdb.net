class UserPodcast < ActiveRecord::Base
	belongs_to :podcast
	belongs_to :user
end
