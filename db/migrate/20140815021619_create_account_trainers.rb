class CreateAccountTrainers < ActiveRecord::Migration
  def change
    create_table :account_trainers do |t|

      t.timestamps
    end
  end
end
