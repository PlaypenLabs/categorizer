class AddFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zendesk_email, :string
    add_column :users, :zendesk_password, :string
  end
end
