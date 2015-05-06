class ChangeTypeToCtypeInCategory < ActiveRecord::Migration
  def change
	rename_column :categories, :type, :ctype
  end
end
