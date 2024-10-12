class AddPositionIdToVotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :votes, :position, foreign_key: true
  end
end
