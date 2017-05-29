class ChangeNicknameToUtf8mb < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :nickname, :string, limit:128, charset:'utf8mb4'
  end
end
