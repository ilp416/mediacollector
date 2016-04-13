class AddAttachmentScreenshotToStuffs < ActiveRecord::Migration
  def self.up
    change_table :stuffs do |t|
      t.attachment :screenshot
    end
  end

  def self.down
    remove_attachment :stuffs, :screenshot
  end
end
