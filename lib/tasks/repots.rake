namespace :repots do
  desc "Send Categorize or Report every Monday and Friday"
  task categorize_report: :environment do
    date = DateTime.now()
    day = date.strftime('%u')
    if day == '5'
      ActionMessage.send_weekly_report
    elsif day == '1'
      User.all.each do |user|
        Ticket.add_tickets(user)
        ReportMailer.sent_weekly_email_categorize(user.email).deliver_now
      end
    end
  end
end
