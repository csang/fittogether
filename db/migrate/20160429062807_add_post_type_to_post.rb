class AddPostTypeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :post_type, :string, :default => 'text'
  end
end
