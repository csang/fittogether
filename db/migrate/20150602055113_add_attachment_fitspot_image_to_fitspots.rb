class AddAttachmentFitspotImageToFitspots < ActiveRecord::Migration
  def self.up
    change_table :fitspots do |t|
      t.attachment :fitspot_image
    end
  end

  def self.down
    remove_attachment :fitspots, :fitspot_image
  end
end
