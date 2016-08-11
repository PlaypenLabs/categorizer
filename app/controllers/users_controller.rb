class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    respond_to do |format|
      format.html
      format.json {
        render json: Ticket.retreive_tickets(current_user)
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

  def receive_report
    ActionMessage.send_weekly_report(current_user)
    redirect_to reports_path, notice: 'Weekly reports are sent successfully'
  end

end
