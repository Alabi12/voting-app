class Position < ApplicationRecord
  has_many :candidates
  has_many :votes, through: :candidates
end
