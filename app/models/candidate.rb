class Candidate < ApplicationRecord
  attr_accessor :vote_percentage
  belongs_to :position
  has_one_attached :image  # Enable image upload with Active Storage
  has_many :votes

  def vote_count
    votes.count
  end
end
