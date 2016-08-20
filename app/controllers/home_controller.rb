class HomeController < ApplicationController

  def index
  end

  def welcome
    current_user.first_login? ? Ticket.add_tickets(current_user) : redirect_to(root_url)
  end

end
