module ReportsHelper
  def get_initial_report_text
    'Here is an example of what your weekly report would look like' if current_user.present? && current_user.first_login?
  end
end
