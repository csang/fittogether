class AddAccountidToFitbit < ActiveRecord::Migration
  def change
    add_column :fitbits, :account_id, :integer
  end
end
