namespace :repots do
  desc "Send Categorize or Report every Monday and Friday"
  task categorize_report: :environment do
    date = DateTime.now()
    day = date.strftime('%u')
    return unless day == '1'

    User.all.each do |user|
        Ticket.add_tickets(user)
        ReportMailer.sent_weekly_email_categorize(user).deliver_now
      end
    end
end
