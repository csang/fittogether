class AddActivityIdsToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :activity_ids, :string
  end
end
