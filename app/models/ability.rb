class Ability
  include CanCan::Ability

  def initialize(user)
    payed_user_abilities = lambda do
      can :set_episodes_count, Podcast
      can :create, Company
      can :read, Company, approved: true
      can [:edit, :update], Company do |company|
        owner = CompanyPerson.exists?(
          company_id: company.id,
          person_id: user.person_id,
          owner: true
        )
        company.approved? && owner
      end
      can :create, CompanyPerson do |cp|
        exists = CompanyPerson.exists?(company_id: cp.company_id, person_id: cp.person_id)
        !exists && (cp.person_id == user.person_id)
      end
      can :create, CompanyPodcast do |cp|
        podcast_approved = cp.podcast.approved?

        relation_approved_person_is_host =
          PersonPodcast.exists?(
            person_id: user.person_id,
            podcast_id: cp.podcast_id,
            position: 'Host',
            approved: true
          )

        podcast_approved && relation_approved_person_is_host
      end
    end

    if user.nil?
      cannot :set_episodes_count, Podcast
      can :index, Company, approved: true
    elsif user.regular?
      cannot :set_episodes_count, Podcast
      can :index, Company, approved: true
    elsif user.silver?
      payed_user_abilities.call
    elsif user.gold?
      payed_user_abilities.call
    elsif user.platinum?
      payed_user_abilities.call
    else
    end
  end
end
