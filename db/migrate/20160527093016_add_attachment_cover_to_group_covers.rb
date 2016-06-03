class AddAttachmentCoverToGroupCovers < ActiveRecord::Migration
  def self.up
    change_table :group_covers do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :group_covers, :cover
  end
end
