class AddEmailSentToReports < ActiveRecord::Migration
  def change
     add_column :reports, :is_emailed, :boolean, default: false
  end
end
