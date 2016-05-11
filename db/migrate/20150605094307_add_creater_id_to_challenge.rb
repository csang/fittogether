class AddCreaterIdToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :creater_id, :integer
  end
end
