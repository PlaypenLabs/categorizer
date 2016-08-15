class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do
      organization = Organization.find_or_create_by(name: URI.encode(params[:organization_name].strip)) if params[:organization_name].present?
      resource.organization = organization
      resource.save
    end
  end

  protected
  def after_sign_up_path_for(resource)
    welcome_url
  end
end
