class Developer < ApplicationRecord
  validates :verification_code, presence: true, uniqueness: true
end
