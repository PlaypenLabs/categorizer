class Ticket < ActiveRecord::Base
  belongs_to :organization
  has_one :report
  has_one :user, through: :report

  validates :organization_id, presence: true

  scope :ordered, -> { order('created_at DESC') }
  scope :last_tickets, -> { where('date >= :last_week', last_week: Date.today - 7) }

  def self.add_tickets(user)
    return false if user.zendesk_email.blank? && user.zendesk_password.blank?
    organization = user.organization
    url = "https://#{organization.name}/api/v2/tickets.json"

    tickets = Array.new()

    while url
      zendesk_tickets = JSON.parse(HTTP.basic_auth(user: user.zendesk_email, pass: user.zendesk_password).get(url))
      tickets += zendesk_tickets['tickets'] if zendesk_tickets['tickets'].present?
      url = zendesk_tickets['next_page']
    end

    tickets.each do |t|
      Ticket.find_or_create_by(id_zendesk: t['id'], organization_id: organization.id) do |ticket|
        ticket.description = t['description']
        ticket.subject = t['subject']
        ticket.id_zendesk = t['id']
        ticket.date = t['created_at']
        ticket.from = t['via']['source']['from']['address']
        ticket.organization_id = organization.id
      end
    end if tickets.present?
  end

  def self.retreive_tickets(user)
    ticket_limits = user.first_login? ? (10 - user.reports.count) : 50
    user.organization.tickets.where('date >= :last_week', last_week: Date.today - 7).ordered.collect{ |t| t.id if t.report.blank? }.compact[0..ticket_limits - 1]
  end

  def self.last_uncategorized_tickets
    self.last_tickets.includes(:report).ordered.collect{ |t| t.id if t.report.blank? }.compact
  end
end
