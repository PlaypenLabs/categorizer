class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :description
      t.datetime :date
      t.string :from
      t.integer :id_zendesk
      t.boolean :replied, default: false
      t.timestamps null: false
    end
  end
end
