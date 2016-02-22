class Ability
  include CanCan::Ability

  def initialize(user)
    payed_user_abilities = lambda do
      can :set_episodes_count, Podcast do |podcast|
        can_set_episode_count_podcast(podcast, user)
      end
      can [:edit, :update], Podcast do |podcast|
        can_edit_update_podcast(podcast, user)
      end
      can :create, Company
      can :read, Company, approved: true
      can [:edit, :update], Company do |company|
        can_edit_update_company(company, user)
      end
      can :create, CompanyPerson do |cp|
        can_create_company_person(cp, user)
      end
      can :create, CompanyPodcast do |cp|
        can_create_company_podcast(cp, user)
      end
      can [:create, :read], Message do |msg|
        can_create_message(msg, user)
      end
    end

    if user.nil?
      cannot :set_episodes_count, Podcast
      can :index, Company, approved: true
    elsif user.basic?
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

  private

  def can_set_episode_count_podcast(podcast, user)
    host = PersonPodcast.exists?(
      podcast_id: podcast.id,
      person_id: user.person_id,
      position: 'Host'
    )
    host && user.payed_subscriber?
  end

  def can_edit_update_podcast(podcast, user)
    PersonPodcast.exists?(
      podcast_id: podcast.id,
      person_id: user.person_id,
      position: 'Host'
    )
  end

  def can_edit_update_company(company, user)
    owner = CompanyPerson.exists?(
      company_id: company.id,
      person_id: user.person_id,
      owner: true
    )
    company.approved? && owner
  end

  def can_create_company_person(cp, user)
    exists = CompanyPerson.exists?(company_id: cp.company_id, person_id: cp.person_id)
    !exists && (cp.person_id == user.person_id)
  end

  def can_create_company_podcast(cp, user)
    podcast_approved = cp.podcast.approved?
    podcast_approved && person_is_approved_host(user.person_id, cp.podcast_id)
  end

  def can_create_message(msg, user)
    PersonPodcast.exists?(
      podcast_id: msg.podcast_id,
      person_id: user.person_id,
      position: 'Host'
    )
  end
end
