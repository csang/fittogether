class AddSummaryCaloriesToFitbit < ActiveRecord::Migration
  def change
    add_column :fitbits, :summary_calories, :integer
    end
end
