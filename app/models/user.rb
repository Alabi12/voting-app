class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :votes
         has_many :voted_candidates, through: :votes, source: :candidate
       
         def voted_for?(position)
           voted_candidates.exists?(position: position)
         end
end
