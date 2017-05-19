class AddAttachmentPhotoToPhotographs < ActiveRecord::Migration
  def self.up
    change_table :photographs do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :photographs, :photo
  end
end
