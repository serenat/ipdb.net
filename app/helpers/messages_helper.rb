module MessagesHelper
  def time_date(date)
    return unless date
    if date.year > Time.now.year
      date.strftime('%d/%m/%y')
    else
      date.to_date == Time.now.to_date ? date.strftime('%l:%M %P') : date.strftime('%b %d')
    end
  end

  def strip_html_tags(text)
    if text
      sanitize(text, tags: ['br']).gsub('<br>', ' ')
    end
  end
end
