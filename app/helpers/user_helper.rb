module UserHelper
  def get_initial_text
    'We have gone and got a sample of your most recent support emails for you to categorize. This categorization is what you will be
    asked to do every week' if current_user.first_login?
  end
end
