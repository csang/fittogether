class AddAttachmentGroupImageToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.attachment :group_image
    end
  end

  def self.down
    remove_attachment :groups, :group_image
  end
end
