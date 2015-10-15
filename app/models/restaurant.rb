class Restaurant < ActiveRecord::Base

  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  def average_rating
    average_rating = 0
    return "N/A" if reviews.none?
    self.reviews.each do |review|
      average_rating += review.rating
    end
    average_rating / self.reviews.length
  end

end
