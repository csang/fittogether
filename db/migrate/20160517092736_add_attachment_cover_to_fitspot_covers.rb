class AddAttachmentCoverToFitspotCovers < ActiveRecord::Migration
  def self.up
    change_table :fitspot_covers do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :fitspot_covers, :cover
  end
end
