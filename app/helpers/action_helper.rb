module ActionHelper
  def can_delete_action?(action)
    action.reports.present?
  end
end
