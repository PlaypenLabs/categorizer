class Organization < ActiveRecord::Base
  has_many :tickets
  has_many :users

  validates :name, presence: true

  def uncategorized_tickets
    self.tickets.last_uncategorized_tickets
  end
end
