class ReportsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @categories = Report.retrieve_grouped_categories.keys
    @actions = Report.retrieve_grouped_actions.keys
  end

  def new
    @r = Report.new
  end

  def create
    @report = Report.new(permit_params_report)
    @report.save ? flash[:notice] = 'Report was successfully created.' : flash[:alert] = @report.errors.full_messages.join
    redirect_to profile_users_path
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
