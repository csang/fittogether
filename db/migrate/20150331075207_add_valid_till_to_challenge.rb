class AddValidTillToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :valid_till, :datetime
  end
end
