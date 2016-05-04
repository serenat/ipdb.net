module PodcastGenresList
  LIST = {
    'Arts': [
      'Design',
      'Fashion & Beauty',
      'Food',
      'Literature',
      'Performing Arts',
      'Visual Arts'
    ],
    'Business': [
      'Business News',
      'Careers',
      'Investing',
      'Management & Marketing',
      'Shopping'
    ],
    'Comedy': nil,
    'Education': [
      'Educational Technology',
      'Higher Education',
      'K-12',
      'Language Courses',
      'Training'
    ],
    'Games & Hobbies': [
      'Automotive',
      'Aviation',
      'Hobbies',
      'Other Games',
      'Video Games'
    ],
    'Government & Organizations': [
      'Local',
      'National',
      'Non-Profit',
      'Regional'
    ],
    'Health': [
      'Alternative Health',
      'Fitness & Nutrition',
      'Self-Help',
      'Sexuality'
    ],
    'Kids & Family': nil,
    'Music': nil,
    'News & Politics': nil,
    'Religion & Spirituality': [
      'Buddhism',
      'Christianity',
      'Hinduism',
      'Islam',
      'Judaism',
      'Other',
      'Spirituality'
    ],
    'Science & Medicine': [
      'Medicine',
      'Natural Sciences',
      'Social Sciences'
    ],
    'Society & Culture': [
      'History',
      'Personal Journals',
      'Philosophy',
      'Places & Travel'
    ],
    'Sports & Recreation': [
      'Amateur',
      'College & High School',
      'Outdoor',
      'Professional'
    ],
    'Technology': [
      'Gadgets',
      'Tech News',
      'Podcasting',
      'Software How-To'
    ],
    'TV & Film': nil
  }

  LOOKUP = {
    'Design'           => 'Arts',
    'Fashion & Beauty' => 'Arts',
    'Food'             => 'Arts',
    'Literature'       => 'Arts',
    'Performing Arts'  => 'Arts',
    'Visual Arts'      => 'Arts',
    'Business News'          => 'Business',
    'Careers'                => 'Business',
    'Investing'              => 'Business',
    'Management & Marketing' => 'Business',
    'Shopping'               => 'Business',
    'Educational Technology' => 'Education',
    'Higher Education'       => 'Education',
    'K-12'                   => 'Education',
    'Language Courses'       => 'Education',
    'Training'               => 'Education',
    'Automotive'  => 'Games & Hobbies',
    'Aviation'    => 'Games & Hobbies',
    'Hobbies'     => 'Games & Hobbies',
    'Other Games' => 'Games & Hobbies',
    'Video Games' => 'Games & Hobbies',
    'Local'      => 'Government & Organizations',
    'National'   => 'Government & Organizations',
    'Non-Profit' => 'Government & Organizations',
    'Regional'   => 'Government & Organizations',
    'Alternative Health' => 'Health',
    'Fitness & Nutrition'=> 'Health',
    'Self-Help'          => 'Health',
    'Sexuality'          => 'Health',
    'Buddhism'     => 'Religion & Spirituality',
    'Christianity' => 'Religion & Spirituality',
    'Hinduism'     => 'Religion & Spirituality',
    'Islam'        => 'Religion & Spirituality',
    'Judaism'      => 'Religion & Spirituality',
    'Other'        => 'Religion & Spirituality',
    'Spirituality' => 'Religion & Spirituality',
    'Medicine'        => 'Science & Medicine',
    'Natural Sciences'=> 'Science & Medicine',
    'Social Sciences' => 'Science & Medicine',
    'History'           => 'Society & Culture',
    'Personal Journals' => 'Society & Culture',
    'Philosophy'        => 'Society & Culture',
    'Places & Travel'   => 'Society & Culture',
    'Amateur'               => 'Sports & Recreation',
    'College & High School' => 'Sports & Recreation',
    'Outdoor'               => 'Sports & Recreation',
    'Professional'          => 'Sports & Recreation',
    'Gadgets'        => 'Technology',
    'Tech News'      => 'Technology',
    'Podcasting'     => 'Technology',
    'Software How-To'=> 'Technology'
  }
end
