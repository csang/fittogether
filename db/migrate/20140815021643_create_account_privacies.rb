class CreateAccountPrivacies < ActiveRecord::Migration
  def change
    create_table :account_privacies do |t|

      t.integer 'account_id'
      t.boolean 'profile_pic'
      t.boolean 'email'
      t.boolean 'mobile'
      t.boolean 'birthday'
      t.boolean 'work'
      t.boolean 'location'
      
      t.timestamps
    end
    add_index('account_privacies', :account_id)
  end
end
