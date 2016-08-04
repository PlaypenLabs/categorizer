class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    # List Tickets
    # curl https://playpenlabs.zendesk.com/api/v2/tickets.json \
    # -v -u zendesk@playpenlabs.com:...
    last_week = Date.today-7
    @tickets = Ticket.where('date >= :last_week', last_week:last_week)
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
    Ticket.add_tickets(current_user)
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
