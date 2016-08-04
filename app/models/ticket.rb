class Ticket < ActiveRecord::Base
  has_one :report

  def self.add_tickets(user)
    return false if user.zendesk_email.blank? && user.zendesk_password.blank?
    tickets =  JSON.parse(HTTP.basic_auth(user: user.zendesk_email, pass: user.zendesk_password).get('https://playpenlabs.zendesk.com/api/v2/tickets.json'))['tickets']
    tickets.each do |t|
      Ticket.find_or_create_by(id_zendesk:t['id']) do |ticket|
        ticket.description = t['description']
        ticket.subject = t['subject']
        ticket.id_zendesk = t['id']
        ticket.date = t['created_at']
        ticket.from = t['via']['source']['from']['address']
      end
    end
  end
end
