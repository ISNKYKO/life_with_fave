class Post < ApplicationRecord
  has_one_attached :image
  
  enum status: { draft: 0, published: 1 }
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favoriting_users, through: :favorites, source: :user
  has_many :taggings
  has_many :tags, through: :taggings
  
  scope :drafts, -> { where(status: 'draft') }
  scope :published, -> { where(status: 'published') }
  
  validates :post_title, presence: true
  validates :post_text, presence: true, length: { minimum: 5 }
  
  
  def self.ransackable_attributes(auth_object = nil)
    ["post_title", "post_text", "image"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["favorites", "image_attachment", "image_blob", "post_comments", "user"]
  end
  
  def get_image
   unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
   image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def tag_list
    tags.map(&:name).join(', ')
  end
  
  def draft?
    status == 'draft'
  end

  def published?
    status == 'published'
  end
  
  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
end
