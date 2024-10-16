class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :position
  belongs_to :candidate, counter_cache: true

  # validates :user_id, uniqueness: { scope: [:candidate_id, :position_id] } # Ensure one vote per user per candidate per position
end
