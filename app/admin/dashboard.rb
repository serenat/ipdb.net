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
        panel "Recent Companies" do
          table_for Company.limit(20).order('created_at desc') do
            column "Company" do |company|
              link_to company.name, admin_company_path(company)
            end
            column :onwer do |company|
              person = company.companies_people.where(owner: true).take.try(:person)
              link_to person.name, person if person
            end
            column "" do |company|
              unless company.approved?
                link_to 'APPROVE', approve_admin_company_path(company), method: :put
              end
            end
            column :approved
          end
        end
      end
    end

    columns do
      column do
        panel "Person <~> Podcast" do
          table_for PersonPodcast.order('created_at desc').limit(20) do
            column :id do |pp|
              link_to pp.id, admin_person_podcast_path(pp)
            end
            column :person do |pp|
              person = Person.find(pp.person_id)
              if person
                link_to person.name, admin_person_path(person)
              end
            end

            column :podcast do |pp|
                podcast = Podcast.find(pp.podcast_id)
                if podcast
                  link_to podcast.name, admin_podcast_path(podcast)
                end
            end
            column :position
            column "" do |pp|
              unless pp.approved?
                link_to 'APPROVE', approve_admin_person_podcast_path(pp), method: :put
              end
            end
            column :approved
          end
        end
      end
      column do
        panel "Person <~> Company" do
          table_for CompanyPerson.order('created_at desc').limit(20) do
            column :id do |cp|
              link_to cp.id, admin_company_person_path(cp)
            end
            column :person do |cp|
              person = Person.find(cp.person_id)
              if person
                link_to person.name, admin_person_path(person)
              end
            end
            column :company do |cp|
                company = Company.find(cp.company_id)
                if company
                  link_to company.name, admin_company_path(company)
                end
            end
            column "" do |cp|
              unless cp.approved?
                link_to 'APPROVE', approve_admin_company_person_path(cp), method: :put
              end
            end
            column :approved
          end
        end

        panel "Podcast <~> Company" do
          table_for CompanyPodcast.order('created_at desc').limit(20) do
            column :id do |cp|
              link_to cp.id, admin_company_podcast_path(cp)
            end
            column :podcast do |cp|
              podcast = Podcast.find(cp.podcast_id)
              if podcast
                link_to podcast.name, admin_podcast_path(podcast)
              end
            end
            column :company do |cp|
                company = Company.find(cp.company_id)
                if company
                  link_to company.name, admin_company_path(company)
                end
            end
            column "" do |cp|
              unless cp.approved?
                link_to 'APPROVE', approve_admin_company_podcast_path(cp), method: :put
              end
            end
            column :approved
          end
        end
      end
    end
  end
end
