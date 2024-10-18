class AddEmailToDevelopers < ActiveRecord::Migration[7.1]
  def change
    add_column :developers, :email, :string
  end
end
