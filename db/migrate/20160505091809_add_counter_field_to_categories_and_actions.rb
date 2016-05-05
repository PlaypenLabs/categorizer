class AddCounterFieldToCategoriesAndActions < ActiveRecord::Migration
  def change
    add_column :categories, :reports_count, :integer
    add_column :action_messages, :reports_count, :integer
  end
end
