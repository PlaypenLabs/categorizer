class AddOrganizationIdToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :organization, index: true, foreign_key: true
  end
end
