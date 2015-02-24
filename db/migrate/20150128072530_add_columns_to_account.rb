class AddColumnsToAccount < ActiveRecord::Migration
  def change
	    add_column :accounts, :fb_link, :string
	    add_column :accounts, :tw_link, :string
	    add_column :accounts, :google_link, :string
	    add_column :accounts, :linked_link, :string
  end
end
