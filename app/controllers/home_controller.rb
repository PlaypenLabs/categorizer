class HomeController < ApplicationController

  def index
  end

  def welcome
    redirect_to(root_url) unless current_user.first_login?
  end

end
