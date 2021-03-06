class ItunesReviewsParser

  def initialize(xml)
    @xml = xml
  end

  def reviews
    doc = Nokogiri::XML(xml)
    parse_entries doc.css('entry')
  end

  private

  attr_reader :xml

  def parse_entry(entry)
    {
      itunes_id:    entry.at_css('id').text,
      author:       entry.at_css('author name').text[0,191],
      title:        entry.at_css('title').text[0,191],
      commented_at: to_time(entry.at_css('updated').text),
      content:      entry.at_css('content[type=text]').text,
      rating:       entry.at_css('im|rating').text,
      itunes:       true
    }
  end

  def parse_entries(entries)
    entries = remove_head_entry(entries)
    entries.map do |entry|
      parse_entry(entry)
    end
  end

  def remove_head_entry(entries)
    entries.drop(1)
  end

  def to_time(str)
    Time.parse(str)
  end

end
