class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
