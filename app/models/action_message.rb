class ActionMessage < ActiveRecord::Base
  belongs_to :user
  has_many :reports, foreign_key: :action_id
  has_many :tickets

  validates :name, presence: true
  validates :recipient, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: ' email format is invalid' }, if: lambda { |recipient| self.recipient.present? }
end
