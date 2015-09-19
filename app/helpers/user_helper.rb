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
end
