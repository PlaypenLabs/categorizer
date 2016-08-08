class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = Report.all
  end

  def new
    @r = Report.new
  end

  def create
    @report = Report.new(permit_params_report)
    Ticket.find(permit_params_report[:ticket_id]).report = @report if @report.save
    redirect_to profile_users_path, notice: @report.valid? ? 'Report was successfully created.' : @report.errors.full_messages.join
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
