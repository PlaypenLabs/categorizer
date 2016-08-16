class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do
      unless valid_organization?
        @user.errors.messages[:organization_id].clear
        flash[:alert] = 'Invalid zendesk credentials.'
        return render :new
      end
      organization = Organization.find_or_create_by(name: params[:organization_name]) if params[:organization_name].present?
      resource.organization = organization
      resource.save
    end
  end

  protected
  def after_sign_up_path_for(resource)
    welcome_url
  end

  def valid_organization?
    begin
      url = "https://#{params[:organization_name]}.zendesk.com/api/v2/organization_memberships.json"
      HTTP.basic_auth(user: params[:user][:zendesk_email], pass: params[:user][:zendesk_password]).get(url).code == 200
    rescue StandardError
      return false
    end
  end
end
