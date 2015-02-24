class CreateAccountGyms < ActiveRecord::Migration
  def change
    create_table :account_gyms do |t|

      t.string 'name'
      
      t.timestamps
    end
  end
end
