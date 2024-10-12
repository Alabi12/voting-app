class AddVoteCountToCandidates < ActiveRecord::Migration[7.1]
  def change
    add_column :candidates, :vote_count, :integer, default: 0, null: false
  end
end
