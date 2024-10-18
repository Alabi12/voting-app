class CreateDevelopers < ActiveRecord::Migration[7.1]
  def change
    create_table :developers do |t|
      t.string :name
      t.string :verification_code

      t.timestamps
    end
  end
end
