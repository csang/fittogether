class CreateAccountEmailSettings < ActiveRecord::Migration
  def change
    create_table :account_email_settings do |t|
      t.integer :account_id
      t.boolean :new_rating, :default => 0
      t.boolean :new_appointment_request, :default => 0
      t.boolean :new_review, :default => 0
      t.boolean :appointment_approve, :default => 0
      t.boolean :group_invitation, :default => 0
      t.boolean :mentioned_in, :default => 0
      t.boolean :comment_on_post, :default => 0

      t.timestamps
    end
  end
end
