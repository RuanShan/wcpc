class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :photograph, foreign_key: true
      t.attachment :photo

      t.timestamps
    end
  end
end
