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

    @tikets_ids = tikets_ids

    respond_to do |format|
      format.html
      format.json {
        render json: @tickets
      }
    end
  end

  def get_ticket_by_id
    id = params[:id]
    ticket = JSON.parse(HTTP.basic_auth(user: current_user.zendesk_email, pass: current_user.zendesk_password).get("https://playpenlabs.zendesk.com/api/v2/tickets/#{id}.json"))['ticket']
    @t = ticket

    p "**" *10
    p @t
    p "**" *10
    p "**" *10
    render partial: 'users/ticket', layout: false
  end

  def report
    # ReportMailer.sent_report_category(permit_params_sent_email).deliver_now

    p "**"*10
    p permit_params_report
    p "**"*10

    Report.create(permit_params_report)
    redirect_to :profile_users
  end

  private

  def permit_params_report
    params.require(:report).permit(:category_id, :action_id, :comment)
  end

end
