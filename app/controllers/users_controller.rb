class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    # List Tickets
    # curl https://playpenlabs.zendesk.com/api/v2/tickets.json \
    # -v -u zendesk@playpenlabs.com:...
    @tiket = HTTP.basic_auth(user: current_user.zendesk_email, pass: current_user.zendesk_password).get('https://playpenlabs.zendesk.com/api/v2/tickets.json')
  end

end
