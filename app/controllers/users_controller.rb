class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @unsent_emails = current_user.reports.latest.unsent_emails
    @uncategorized_tickets = current_user.organization.uncategorized_tickets
    flash[:notice] = 'All tickets are categorized but all reports are not sent yet.' if @unsent_emails.present? && @uncategorized_tickets.blank?
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
    redirect_to profile_users_path
  end

  def recive_category
    ReportMailer.sent_weekly_email_categorize().deliver_now
    render nothing: true
  end

  def receive_report
    ActionMessage.send_weekly_report(current_user)
    current_user.set_email_reports
    redirect_to report_confirmation_users_path, notice: 'Weekly reports are sent successfully'
  end

  def report_confirmation
  end

  def welcome_categorization
    session[:welcome_categorization] = true
    @categories = current_user.categories
    @actions = current_user.action_messages
  end
end
