class ActionMessage < ActiveRecord::Base
  belongs_to :user
  has_many :reports, foreign_key: :action_id
  has_many :tickets

  validates :name, presence: true
  validates :recipient, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: ' email format is invalid' }, if: lambda { |recipient| self.recipient.present? }

  scope :with_recipient, -> { where.not(recipient: [nil, '']) }
  scope :with_report, -> { where.not(reports_count: [nil, 0]) }

  after_save :update_acess_token

  def self.send_weekly_report(user)
    user.action_messages.with_report.with_recipient.each{ |action| ReportMailer.sent_weekly_email_report(action.recipient, action.access_token).deliver_now }
  end

  private

    def update_acess_token
      self.update_column(:access_token, SecureRandom.urlsafe_base64) if self.access_token.blank? || self.recipient_changed?
    end
end
