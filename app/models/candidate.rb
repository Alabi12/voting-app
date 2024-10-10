class Candidate < ApplicationRecord
  belongs_to :position
  has_many :votes
end
