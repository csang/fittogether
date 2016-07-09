class AddColorToAccountGym < ActiveRecord::Migration
  def change
    add_column :account_gyms, :color, :string
  end
end
