namespace :repots do
  desc "Send Categorize or Report every Monday and Friday"
  task categorize_report: :environment do
    date = DateTime.now()
    d = date.strftime('%u')
    h = date.strftime('%H')
    # if today Friday then send weekly report to REPORTER
    # else if today Monday then send weekly categorized ticket
    if d=='5'
      p 'Today Friday'
      ReportMailer.sent_weekly_email_report().deliver_now
    elsif d == '1'
      p 'Today  Monday'
      tickets = JSON.parse(HTTP.basic_auth(user: 'zendesk@playpenlabs.com', pass: 'devzd').get('https://playpenlabs.zendesk.com/api/v2/tickets.json'))['tickets']
      tickets.each do |t|
        Ticket.find_or_create_by(id_zendesk:t['id']) do |ticket|
          ticket.description = t['description']
          ticket.subject = t['subject']
          ticket.id_zendesk = t['id']
          ticket.date = t['created_at']
          ticket.from = t['via']['source']['from']['address']
        end
      end
      ReportMailer.sent_weekly_email_categorize().deliver_now
    else
      p '**' *10
      p '**' *10
      p "Today is not MONDAY or FRIDAY because today #{date.strftime('%^A')}"
      p '**' *10
      p '**' *10
    end
  end

end
