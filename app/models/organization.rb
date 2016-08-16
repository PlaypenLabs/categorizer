class Organization < ActiveRecord::Base
  has_many :tickets
  has_many :users

  validates :name, presence: true
  before_create :add_zendesk_domain

  def add_zendesk_domain
    self.name = [self.name.strip, '.zendesk.com'].join
  end
end
