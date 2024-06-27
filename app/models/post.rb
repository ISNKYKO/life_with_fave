class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :post_title, presence: true
  validates :post_text, presence: true, length: { minimum: 10 }
  
  def self.ransackable_attributes(auth_object = nil)
    ["post_title", "post_text"]  # 検索可能な属性を指定
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
  
end
