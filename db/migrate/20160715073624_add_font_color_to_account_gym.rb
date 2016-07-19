class AddFontColorToAccountGym < ActiveRecord::Migration
  def change
    add_column :account_gyms, :font_color, :string
  end
end
