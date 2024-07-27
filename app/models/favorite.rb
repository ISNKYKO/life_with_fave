class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  
  validates :user_id, uniqueness: {scope: :post_id}
  
  after_create :create_timeline_item

  private

  def create_timeline_item
    TimelineItem.create(user: user, content: "favorited post #{post.id}")
  end
  
end
