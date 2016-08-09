class ActionMessage < ActiveRecord::Base
  belongs_to :user
  has_many :reports, foreign_key: :action_id
  has_many :tickets

  validates :name, presence: true
  validates :recipient, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: ' email format is invalid' }, if: lambda { |recipient| self.recipient.present? }

  scope :with_recipient, -> { where.not(recipient: [nil, '']) }

  def self.send_weekly_report
    ActionMessage.with_recipient.pluck(:recipient).each{ |email| ReportMailer.sent_weekly_email_report(email).deliver_now }
  end
end
