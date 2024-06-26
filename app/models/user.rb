class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true       
  validates :telephone_number, presence: true, numericality: {only_integer: true}
         
  has_one_attached :profile_image       
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
 def update_without_current_password(params, *options)
      if params[:password].blank? && params[:password_confirmation].blank?
         params.delete(:password)
         params.delete(:password_confirmation)
      end
      
      result = update(params, *options)
      clean_up_passwords
      result
  end
  
  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
end

