class AddUserDetailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :gender, :integer
    add_column :users, :avatar, :string
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
  end
end
