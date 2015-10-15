class Restaurant < ActiveRecord::Base

  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  def average_rating
    total_rating = 0
    return "N/A" if reviews.none?
    reviews.each do |review|
      total_rating += review.rating
    end
    total_rating / reviews.length
  end

end
