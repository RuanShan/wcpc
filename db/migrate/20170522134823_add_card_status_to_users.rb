class AddCardStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :card_status, :integer
  end
end
