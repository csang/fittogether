class AddGymIdToAccountTrainers < ActiveRecord::Migration
  def change
    add_column :account_trainers, :gym_id, :integer
    add_column :account_trainers, :fitness_discpline, :string
    add_column :account_trainers, :certs, :string
    add_column :account_trainers, :awards, :string
    add_column :account_trainers, :personal_training, :string
    add_column :account_trainers, :age, :integer
    add_column :account_trainers, :bootcamp, :string
    add_column :account_trainers, :location_bootcamp, :string
    add_column :account_trainers, :group_training, :string
    add_column :account_trainers, :affiliate, :string
    add_column :account_trainers, :url, :string
    add_column :account_trainers, :train_user_type, :string
    add_column :account_trainers, :home_training, :string
  end
end
