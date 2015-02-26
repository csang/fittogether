class AddColumnsToMoreTrainers < ActiveRecord::Migration
  def change
	add_column :account_trainers, :workout_tips, :string
	add_column :account_trainers, :certificates ,:string
  end
end
