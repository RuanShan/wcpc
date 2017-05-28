class AddAttachmentLogoToShops < ActiveRecord::Migration
  def self.up
    change_table :shops do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :shops, :logo
  end
end
