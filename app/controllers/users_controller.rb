class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    # List Tickets
    # curl https://playpenlabs.zendesk.com/api/v2/tickets.json \
    # -v -u zendesk@playpenlabs.com:...
    @tickets = Ticket.all #TODO change to last week
    tikets_ids = []

    @tickets.each do |t|
      if t.report.blank?
        tikets_ids.push(t['id'])
      end
    end

    @tikets_ids = tikets_ids

    respond_to do |format|
      format.html
      format.json {
        render json: @tikets_ids
      }
    end
  end

  def get_ticket_by_id
    id = params[:id]
    ticket = Ticket.find_by(id:id)
    @t = ticket
    render partial: 'users/ticket', layout: false
  end

  def get_tickets
    @tickets = JSON.parse(HTTP.basic_auth(user: current_user.zendesk_email, pass: current_user.zendesk_password).get('https://playpenlabs.zendesk.com/api/v2/tickets.json'))['tickets']
    @tickets.each do |t|
      Ticket.find_or_create_by(id_zendesk:t['id']) do |ticket|
        ticket.description = t['description']
        ticket.subject = t['subject']
        ticket.id_zendesk = t['id']
        ticket.date = t['created_at']
        ticket.from = t['via']['source']['from']['address']
      end
    end
    redirect_to '/users/profile'
  end

  def recive_category
    ReportMailer.sent_weekly_email_categorize().deliver_now
    render nothing: true
  end

  def recive_report
    ReportMailer.sent_weekly_email_report().deliver_now
    render nothing: true
  end

end
