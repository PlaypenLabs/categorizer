class ActionsController < ApplicationController
  before_action :authenticate_user!, except: [:actions_report]
  before_action :set_action, only: [:edit, :update, :destroy]

  def index
    @a = current_user.action_messages
  end

  def new
    @action = ActionMessage.new()
  end

  def create
    @action = current_user.action_messages.new(action_message_params_permit)
    if @action.save
      redirect_to action_messages_path, notice: 'Action was successfully created.'
    else
      flash[:error] = @action.errors.full_messages.join
      render :new
    end
  end

  def edit
  end

  def update
    if @action.update(action_message_params_permit)
      redirect_to action_messages_path, notice: 'Action was successfully updated.'
    else
      flash[:error] = @action.errors.full_messages.join
      render :edit
    end
  end

  def destroy
    if @action.reports.present?
      flash[:error] = 'It has reports so it can not be deleted'
    else
      flash[:notice] = 'Action was successfully deleted.'
      @action.destroy
    end
    redirect_to action_messages_path
  end

  def actions_report
    @action = ActionMessage.find(params[:action_message_id])
    @reports = @action.reports
  end

  private

  def action_message_params_permit
    params.require(:action_message).permit(:name, :recipient)
  end

  def set_action
    @action = ActionMessage.find(params[:id])
  end

end
