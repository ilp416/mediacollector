class AddAttachmentPictureToStuffs < ActiveRecord::Migration
  def self.up
    change_table :stuffs do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :stuffs, :picture
  end
end
