class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :origin
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
