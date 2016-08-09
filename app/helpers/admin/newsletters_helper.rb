module Admin::NewslettersHelper
  def newsletter_sent_time(newsletter)
    sent_time = newsletter.sent_at

    if !sent_time.nil?
      content_tag :p, class: "help-block"
        "Sent at: " + time.to_formatted_s(:long)
      end
  end
end
