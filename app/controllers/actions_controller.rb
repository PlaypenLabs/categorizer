class ActionsController < ApplicationController

  def index
    @a = current_user.action_messages
  end

  def new
    @a = ActionMessage.new()
  end

  def create
    a = current_user.action_messages.create(action_message_params_permit)
    redirect_to action_messages_path
  end

  def edit
    @a = ActionMessage.find(params[:id])
  end

  def update
    a = ActionMessage.find(params[:id])
    a.update(action_message_params_permit)
    redirect_to action_messages_path
  end

  def destroy
    ActionMessage.find(params[:id]).destroy
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

end
