ActiveAdmin.register_page "Dashboard" do
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Podcasts" do
          table_for Podcast.limit(20).order('created_at desc') do
            column "Podcast" do |podcast|
              link_to podcast.name, admin_podcast_path(podcast)
            end
            column :approved
            column :user_approved
          end
        end
      end
 
      column do
        panel "New Connections" do
          table_for UserPodcast.order('created_at desc').limit(20) do
            column :user do |user|
              u = User.find_by_id(user.user_id)
                if u.nil?
                  link_to user.id, admin_connection_path(user)
                else
                  link_to u.username, admin_connection_path(user)
                end
            end


            column :podcast do |podcast|
                p = Podcast.find_by_id(podcast.podcast_id)
                  if p.nil?
                  link_to podcast.podcast_id, admin_connection_path(podcast)
                else
                  link_to p.name, admin_connection_path(podcast)
                end
            end
            column :position
            column :approved
          end
        end
      end
    end
  end
end