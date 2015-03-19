class ChangepostItTopostIdInComment < ActiveRecord::Migration
  def change
  rename_column :comments, :post_it, :post_id
  end
end
