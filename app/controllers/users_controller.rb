class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    # List Tickets
    # curl https://playpenlabs.zendesk.com/api/v2/tickets.json \
    # -v -u zendesk@playpenlabs.com:...
    @tickets = JSON.parse(HTTP.basic_auth(user: current_user.zendesk_email, pass: current_user.zendesk_password).get('https://playpenlabs.zendesk.com/api/v2/tickets.json'))['tickets']
    tikets_ids = []

    @tickets.each do |t|
      tikets_ids.push(t['id'])
    end

    respond_to do |format|
      format.html
      format.json {
        render json: tikets_ids
      }
    end
  end

  def get_ticket_by_id
    id = params[:id]
    ticket = JSON.parse(HTTP.basic_auth(user: current_user.zendesk_email, pass: current_user.zendesk_password).get("https://playpenlabs.zendesk.com/api/v2/tickets/#{id}.json"))['ticket']
    @t = ticket
    render partial: 'users/ticket', layout: false
  end

end
