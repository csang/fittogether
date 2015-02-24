class CreatePrivacies < ActiveRecord::Migration
  def change
    create_table :privacies do |t|

      t.string 'name', :limit => 20

      t.timestamps
    end
  end
end
