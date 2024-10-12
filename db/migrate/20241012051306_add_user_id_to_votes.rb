class AddUserIdToVotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :votes, :user, foreign_key: true # remove null: false
  end
end
