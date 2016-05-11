class AddAttachmentCoverToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :accounts, :cover
  end
end
