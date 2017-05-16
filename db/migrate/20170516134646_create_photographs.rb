class CreatePhotographs < ActiveRecord::Migration[5.0]
  def change
    create_table :photographs do |t|
      t.string :name
      t.text :intro
      t.text :manifesto
      t.integer :vote_numbers
      t.references :activity, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
