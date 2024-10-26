class Candidate < ApplicationRecord
  attr_accessor :vote_percentage
  belongs_to :position
  has_one_attached :image  # Enable image upload with Active Storage
  has_many :votes

  after_initialize :set_default_votes_count, if: :new_record?

  private

  def set_default_votes_count
    self.votes_count ||= 0
  end
end
