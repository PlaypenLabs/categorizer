class Category < ActiveRecord::Base
  DEFAULT_CATEGORIES = ['User account', 'Dashboard', 'Login', 'Billing']
  belongs_to :user
  has_many :reports
  has_many :tickets

  validates :name, presence: true
end
