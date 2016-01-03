module PodcastsHelper
  AWARDS_LOOKUP = {
    'Podcast Award Winner' => ['fa-trophy', 'gold'],
    'Podcast Award Nominee' => ['fa-trophy'],
    'Stitcher Award Nominee' => ['fa-sliders', 'purple'],
    'Stitcher Award Winner' => ['fa-sliders', 'gold'],
    'Parsec Award Nominee' => ['fa-star', 'purple'],
    'Parsec Award Winner' => ['fa-star', 'gold'],
    'IPDb Nominee' => ['fa-headphones', 'purple'],
    'IPDb Winner' => ['fa-headphones', 'gold'],
    'European Podcast Awards Nominee' => ['fa-microphone', 'purple'],
    'European Podcast Awards Winner' => ['fa-microphone', 'gold']
  }

  def connection_positions
    PersonPodcast::POSITIONS
  end

  def award_icon(award)
    classes = ["fa", "fa-15x"]
    classes << AWARDS_LOOKUP[award]
    content_tag(:i, nil, class: classes)
  end

  def rank(prev_page, index)
    prev_page.to_i * 25 + (index + 1)
  end

  def categories_list
    [
      'arts', 'business', 'comedy', 'education', 'games & hobbies', 'government & organizations',
      'health', 'kids & family', 'music', 'news & politics', 'religion & spirituality',
      'science & medicine', 'society & culture', 'sports & recreation', 'technology', 'tv & film'
    ]
  end

  def host?(user, podcast)
    if user && podcast
      PersonPodcast.where(person: user.person, podcast: podcast, position: 'Host').first
    end
  end

  def podcast_art_url(podcast, size = nil)
    if podcast.image_url.blank?
      podcast.image.url(size)
    else
      podcast.image_url
    end
  end
end
