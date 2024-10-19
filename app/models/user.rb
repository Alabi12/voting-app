class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
