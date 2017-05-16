class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :intro
      t.integer :traffic
      t.datetime :start_time
      t.datetime :terminate_time
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
