class AddQtyToChallenges < ActiveRecord::Migration
  def change
  add_column :challenges, :qty, :integer
  end
end
