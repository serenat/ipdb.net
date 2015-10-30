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
    ['Host', 'Co-host', 'Guest', 'Artwork', 'Music', 'Sound Engineer', 'Performer']
  end

  def award_icon(award)
    classes = ["fa", "fa-15x"]
    classes << AWARDS_LOOKUP[award]
    content_tag(:i, nil, class: classes)
  end

  def rank(prev_page, index)
    prev_page.to_i * 25 + (index + 1)
  end
end
