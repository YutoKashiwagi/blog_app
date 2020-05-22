class AddNameToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :name, :string
    change_column :users, :name, :string, null: false
  end

  def true
    add_column :users, :name, :string
  end
end
