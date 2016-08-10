class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :action_id
      t.integer :category_id
      t.integer :user_id
      t.integer :ticket_id
      t.string  :comment
      t.timestamps null: false
    end
  end
end
