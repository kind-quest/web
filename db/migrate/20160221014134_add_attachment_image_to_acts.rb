class AddAttachmentImageToActs < ActiveRecord::Migration
  def self.up
    change_table :acts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :acts, :image
  end
end
