class AddShopRefToCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :shop, foreign_key: true
  end
end
