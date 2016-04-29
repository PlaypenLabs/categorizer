class CreateActionMessages < ActiveRecord::Migration
  def change
    create_table :action_messages do |t|
      t.string :name
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
