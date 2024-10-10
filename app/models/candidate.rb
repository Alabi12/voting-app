class Candidate < ApplicationRecord
  belongs_to :position
  has_one_attached :image  # Enable image upload with Active Storage
  has_many :votes, dependent: :destroy
end
