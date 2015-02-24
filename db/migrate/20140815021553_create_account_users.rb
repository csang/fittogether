class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :account_users do |t|

      t.belongs_to :account
      t.string 'account_url', :limit => 30
      t.belongs_to :account_trainer
      t.belongs_to :account_pro
      t.boolean 'gym_enrollment'
      t.belongs_to :gym
      t.belongs_to :title
      t.boolean 'gender'
      t.belongs_to :relationship
      t.integer 'birthday'
      t.string 'address'
      t.belongs_to :industry
      t.belongs_to :company

      t.timestamps
    end
  end
end