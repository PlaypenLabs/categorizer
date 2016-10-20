class ReportMailer < ApplicationMailer
  helper MailerHelper
  default from:'categorizer@playpenlabs.com'

  def sent_report_category(params)
    @params = params
    mail(to: "#{params['action']}", subject: "#{params['category']}", message: "#{params['email_text']}")
  end

  def sent_weekly_email_categorize(user)
    @user = user
    subject = @user.first_week? ? 'Userchamp - Your first batch of conversations is ready to be analyzed' : 'This weeks email are ready to be analyzed'
    mail(to: "#{user.email}", subject: subject)
  end

  def sent_weekly_email_report(params, access_token)
    @message = 'Your report on support emails received in the last 7 days is ready.'
    @access_token = access_token
    mail(to: "#{params}", subject: 'This week report on support emails is ready', message: @message)
  end

end
