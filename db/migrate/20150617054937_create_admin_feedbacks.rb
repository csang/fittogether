class CreateAdminFeedbacks < ActiveRecord::Migration
  def change
    create_table :admin_feedbacks do |t|
      t.integer :category_id
      t.text :feedback
      t.integer :account_id
      t.boolean :status , :default => true

      t.timestamps
    end
  end
end
