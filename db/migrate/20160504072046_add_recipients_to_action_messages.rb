class AddRecipientsToActionMessages < ActiveRecord::Migration
  def change
    add_column :action_messages, :recipient, :string
  end
end
