class AddRewardPointsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :reward_points, :integer
  end
end
