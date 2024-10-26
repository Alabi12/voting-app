class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :votes # Assuming you have a Vote model
         def voted_for?(position)
          votes.exists?(candidate: position.candidates)
        end

         # Method to check if the user has already voted for a position
         def voted_for?(position)
          votes.joins(:candidate).where(candidates: { position_id: position.id }).exists?
        end

  # Add these attributes to your model
  attribute :admin, :boolean, default: false
  attribute :developer, :boolean, default: false

  scope :voters, -> { where(role: 'voter') }

  # Role checks
  def admin?
    self.admin
  end

  def developer?
    self.developer
  end

  def voter?
    self.role == 'voter'  # Replace 'role' with the appropriate attribute name if needed
  end
end
