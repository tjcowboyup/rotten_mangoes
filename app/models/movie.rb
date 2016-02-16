class Movie < ActiveRecord::Base
  
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image,
    presence: true
  validate :image_size_validation


  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  mount_uploader :image, ImageUploader
  
  def review_average
    if reviews.sum(:rating_out_of_ten) == 0
      "No user reviews yet"
    else 
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end
  
  def self.search(search)
    # where("title LIKE ? OR director LIKE ?", "%#{search}%", "%#{search}%")
    if search
      where(["title LIKE ? OR director LIKE ?", "%#{search}%", "%#{search}%"])
    else
      all.order('created_at DESC')
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end  

end
