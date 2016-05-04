class ReportMailer < ApplicationMailer
  default from:'categorizer@playpenlabs.com'

  def sent_report_category(params)
    @params = params
    mail(to: "#{params['action']}", subject: "#{params['category']}", message: "#{params['email_text']}")
    # mail(to: "artem.galas@gmail.com", subject: "#{params['category']}", message: "#{params['email_text']}")
  end

end
