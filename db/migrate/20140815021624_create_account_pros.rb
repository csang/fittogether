class CreateAccountPros < ActiveRecord::Migration
  def change
    create_table :account_pros do |t|

      t.timestamps
    end
  end
end
