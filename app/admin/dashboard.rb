ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
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
          table_for PersonPodcast.order('created_at desc').limit(20) do
            column :person do |pp|
              person = Person.find(pp.person_id)
              if person.nil?
                link_to pp.id, admin_connection_path(pp)
              else
                link_to person.name, admin_connection_path(pp)
              end
            end

            column :podcast do |pp|
                podcast = Podcast.find(pp.podcast_id)
                if podcast.nil?
                  link_to pp.podcast_id, admin_connection_path(pp)
                else
                  link_to podcast.name, admin_connection_path(pp)
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