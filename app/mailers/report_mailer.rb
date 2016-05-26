class ReportMailer < ApplicationMailer
  default from:'categorizer@playpenlabs.com'

  def sent_report_category(params)
    @params = params
    mail(to: "#{params['action']}", subject: "#{params['category']}", message: "#{params['email_text']}")
    # mail(to: "artem.galas@gmail.com", subject: "#{params['category']}", message: "#{params['email_text']}")
  end

  def sent_weekly_email_categorize()
    @message = 'You support emails is ready to be categorized.'
    # mail(to: "#{params['user_email']}", subject: 'This weeks email are ready to be analyzed', message: @message)
    mail(to: "artem.galas@gmail.com", subject: 'This weeks email are ready to be analyzed', message: @message)
  end

  def sent_weekly_email_report()
    @message = 'You report on support email received it the last 7days is ready.'
    # mail(to: "#{params['user_email']}", subject: 'This week report on support emails is ready', message: @message)
    mail(to: "artem.galas@gmail.com", subject: 'This week report on support emails is ready', message: @message)
  end

end
