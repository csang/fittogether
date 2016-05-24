class AddAttachmentCoverToAccountCovers < ActiveRecord::Migration
  def self.up
    change_table :account_covers do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :account_covers, :cover
  end
end
