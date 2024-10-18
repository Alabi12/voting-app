class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :votes
  has_many :voted_candidates, through: :votes, source: :candidate

  # Check if a user has voted for a specific position
  def voted_for?(position)
    voted_candidates.exists?(position: position)
  end

  # Roles: 'admin', 'voter'
  enum role: { admin: 'admin', voter: 'voter', developer: 'developer' }

  validates :verification_code, presence: true, if: :developer?
  # No need for a custom admin? method since Rails already provides one
end
