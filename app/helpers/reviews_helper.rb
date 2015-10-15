module ReviewsHelper

  def average_rating
    total_rating = 0
    return "N/A" if reviews.none?
    reviews.each do |review|
      total_rating += review.rating
    end
    total_rating / reviews.length
  end

  def star_rating
    ('★' * (self.average_rating)) + '☆' * (5-self.average_rating)
  end
end
