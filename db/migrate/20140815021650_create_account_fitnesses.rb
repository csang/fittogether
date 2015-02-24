class CreateAccountFitnesses < ActiveRecord::Migration
  def change
    create_table :account_fitnesses do |t|

      t.integer 'account_id'
      t.integer 'steps'
      t.integer 'calories'
      t.integer 'weight'
      t.integer 'distance'
      t.integer 'speed'

      t.timestamps
    end
    add_index('account_fitnesses', :account_id)
  end
end
