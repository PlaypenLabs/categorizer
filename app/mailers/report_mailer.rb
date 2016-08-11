class ReportMailer < ApplicationMailer
  default from:'categorizer@playpenlabs.com'

  def sent_report_category(params)
    @params = params
    mail(to: "#{params['action']}", subject: "#{params['category']}", message: "#{params['email_text']}")
  end

  def sent_weekly_email_categorize(params)
    @message = 'Your sample of support emails is ready to be categorized.'
    mail(to: "#{params}", subject: 'This weeks email are ready to be analyzed', message: @message)
  end

  def sent_weekly_email_report(params, access_token)
    @message = 'Your report on support emails received in the last 7 days is ready.'
    @access_token = access_token
    mail(to: "#{params}", subject: 'This week report on support emails is ready', message: @message)
  end

end
