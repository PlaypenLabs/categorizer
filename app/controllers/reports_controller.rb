class ReportsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_user, only: [:index]
  before_action :verify_categorization, only: [:index]

  def index
    @categories = Report.retrieve_grouped_categories(@user).keys
    @actions = Report.retrieve_grouped_actions(@user).keys
  end

  def new
    @r = Report.new
  end

  def create
    @report = Report.new(permit_params_report)
    @report.user = current_user
    @report.save ? flash[:notice] = 'Report was successfully created.' : flash[:alert] = @report.errors.full_messages.join
    redirect_to redirect_path
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

  def find_user
    return @user = current_user if current_user.present?
    @user = ActionMessage.where(access_token: params[:access_token]).first.try(:user)
    redirect_to root_url, alert: 'Do not have enough rights to view reports' if @user.blank?
  end

  def redirect_path
    current_user.organization.uncategorized_tickets.present? ? profile_users_path : reports_path
  end

  def verify_categorization
    redirect_to profile_users_path, alert: 'Categorize all tickets in order to procced' if current_user.organization.uncategorized_tickets.present?
  end

end
