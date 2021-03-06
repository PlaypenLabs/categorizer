ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :zendesk_email, :zendesk_password

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank? && params[:user][:zendesk_password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
        params[:user].delete('zendesk_password')
      end
      super
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :zendesk_email
    column :created_at
    actions
  end

  filter :email
  filter :zendesk_email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :zendesk_email
      f.input :zendesk_password
    end
    f.actions
  end



end
