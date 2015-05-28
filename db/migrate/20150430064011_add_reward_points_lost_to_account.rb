class AddRewardPointsLostToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :reward_points_lost, :integer
  end
end
