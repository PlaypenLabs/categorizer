ActiveAdmin.register Ticket do
  permit_params :subject, :description, :date, :from, :id_zendesk, :organization_id, :replied

  index do
    selectable_column
    id_column
    column :subject
    column :description
    column :from
    column :replied
    column :user do |ticket|
      user = ticket.organization.users.first
      link_to user.email, admin_user_path(user) if user.present?
    end
    column :created_at
    column :date
    actions
  end

  filter :subject
  filter :description
  filter :from
  filter :created_at
  filter :date
  filter :categorize_by_users_in, label: 'Having user', as: :select, collection: proc { User.all.collect{ |user| [user.email, user.id] } }
end
