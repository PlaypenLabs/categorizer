class HomeController < ApplicationController

  def index
    redirect_to user_session_path if current_user.blank?
  end

  def welcome
    current_user.first_login? ? Ticket.add_tickets(current_user) : redirect_to(root_url)
  end

end
