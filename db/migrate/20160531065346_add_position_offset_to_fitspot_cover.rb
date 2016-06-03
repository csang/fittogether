class AddPositionOffsetToFitspotCover < ActiveRecord::Migration
  def change
    add_column :fitspot_covers, :position_offset, :string
  end
end
