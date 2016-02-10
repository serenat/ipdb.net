module UserHelper
  POSITION_LOOKUP =
    {
      'Host' => 'label-success',
      'Co-Host' => 'label-warning',
      'Art Work' => 'label-primary',
      'Music' => 'label-default',
      'Sound Engineer' => 'label-danger',
      'Performer' => 'label-default',
      'Guest' => 'label-info'
    }

  def position_to_label(pos)
    classes = ['label']
    classes << POSITION_LOOKUP[pos] || 'label-info'
    content_tag(:span, pos, class: classes)
  end

  def membership_levels
    %w(basic silver gold platinum)
  end

  def facebook_link(link)
    if link.blank?
      content_tag(:i, nil, class: 'fa fa-facebook-square fa-2x stub')
    else
      link_to 'http://facebook.com/' + link, target: '_blank' do
        content_tag(:i, nil, class: 'fa fa-facebook-square fa-2x')
      end
    end
  end

  def twitter_link(link)
    if link.blank?
      content_tag(:i, nil, class: 'fa fa-twitter-square fa-2x stub')
    else
      link_to 'http://twitter.com/' + link, target: '_blank' do
        content_tag(:i, nil, class: 'fa fa-twitter-square fa-2x')
      end
    end
  end

  def pinterest_link(link)
    if link.blank?
      content_tag(:i, nil, class: 'fa fa-pinterest-square fa-2x stub')
    else
      link_to 'http://pinterest.com/' + link, target: '_blank' do
        content_tag(:i, nil, class: 'fa fa-pinterest-square fa-2x')
      end
    end
  end

  def instagram_link(link)
    if link.blank?
      content_tag(:i, nil, class: 'fa fa-instagram fa-2x stub')
    else
      link_to 'http://instagram.com/' + link, target: '_blank' do
        content_tag(:i, nil, class: 'fa fa-instagram fa-2x')
      end
    end
  end

  def linkedin_link(link)
    if link.blank?
      content_tag(:i, nil, class: 'fa fa-linkedin-square fa-2x stub')
    else
      link_to 'http://linkedin.com/' + link, target: '_blank' do
        content_tag(:i, nil, class: 'fa fa-linkedin-square fa-2x')
      end
    end
  end

  def imdb_link(link)
    if link.blank?
      content_tag(:i, nil, class: 'fa fa-film fa-2x stub')
    else
      link_to 'http://imdb.com/' + link, target: '_blank' do
        content_tag(:i, nil, class: 'fa fa-film fa-2x')
      end
    end
  end
end
