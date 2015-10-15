class Restaurant < ActiveRecord::Base

  include ReviewsHelper

  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

end
