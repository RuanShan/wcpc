class ChangeToUtf8mb < ActiveRecord::Migration[5.0]
  def change

    change_column :users, :email, :string, limit:128,     null: false, default: ""
    change_column :users, :reset_password_token, :string, limit:128
    change_column :users, :name, :string, limit:128, charset:'utf8mb4'

  end
end
