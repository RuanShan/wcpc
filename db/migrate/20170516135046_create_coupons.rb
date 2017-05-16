class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :serial_number
      t.references :activity, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
