class AddAcessTokenToActionMessages < ActiveRecord::Migration
  def change
    add_column :action_messages, :access_token, :string, limit: 32
  end
end
