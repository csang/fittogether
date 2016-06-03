class AddFieldsToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :description, :text
    add_column :groups, :address, :string
  end
end
