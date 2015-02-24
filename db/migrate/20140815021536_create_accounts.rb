class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|

      t.string 'fit_id'
      t.string 'first_name'
      t.string 'last_name'

      t.timestamps
    end
    add_index('accounts', :id)
  end
end
