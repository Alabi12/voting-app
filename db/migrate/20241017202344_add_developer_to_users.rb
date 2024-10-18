class AddDeveloperToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :developer, :boolean
  end
end
