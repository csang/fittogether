class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :invited_by
      t.string :email
      t.boolean :status , :default => true

      t.timestamps
    end
  end
end
