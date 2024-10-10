class CreateCandidates < ActiveRecord::Migration[7.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :image_url
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
