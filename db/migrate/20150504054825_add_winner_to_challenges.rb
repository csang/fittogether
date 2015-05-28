class AddWinnerToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :winner_id, :integer
  end
end
