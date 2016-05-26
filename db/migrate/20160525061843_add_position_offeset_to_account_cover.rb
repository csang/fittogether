class AddPositionOffesetToAccountCover < ActiveRecord::Migration
  def change
    add_column :account_covers, :position_offset, :string
  end
end
