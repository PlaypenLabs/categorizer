class ReportsController < ApplicationController

  def index
    @reports = Report.all
  end

  def new
    @r = Report.new
  end

  def create
    report = Report.create(permit_params_report)
    Ticket.find(permit_params_report[:ticket_id]).report = report
    redirect_to :profile_users
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def permit_params_report
    params.require(:report).permit(:category_id, :action_id, :comment, :ticket_id)
  end

end
