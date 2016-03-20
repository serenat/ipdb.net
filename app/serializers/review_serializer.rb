class ReviewSerializer < BaseSerializer
  attributes :id, :title, :author, :content, :rating, :commented_at, :commented_at_formated, :url, :itunes
  has_one :comment
  belongs_to :user

  def url
    review_path(object)
  end

  def commented_at_formated
    ldate object.commented_at
  end
end
