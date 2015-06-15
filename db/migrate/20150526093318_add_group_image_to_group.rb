class AddGroupImageToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :group_image, :string
  end
end
