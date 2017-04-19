module MailerHelper
  def weekly_email_subject(user)
    user.first_week? ? 'Your first batch of conversations is ready to be analyzed' : 'This weeks email are ready to be analyzed'
  end

  def weekly_email_body(user)
    user.first_week? ? 'Your first sample of support conversations is ready to be analyzed. You will very soon have your first weekly report.' : 'Your sample of support emails is ready to be categorized.'
  end

  def weekly_email_categorization_link(user)
   user.first_week? ? welcome_categorization_users_url(host: ENV['HOST']) :  profile_users_url(host: ENV['HOST'])
  end
end
