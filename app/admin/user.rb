ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :zendesk_email, :zendesk_password

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
