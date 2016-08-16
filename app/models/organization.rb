class Organization < ActiveRecord::Base
  has_many :tickets
  has_many :users

  validates :name, presence: true
end
