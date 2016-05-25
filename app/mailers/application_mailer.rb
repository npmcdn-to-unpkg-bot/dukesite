class ApplicationMailer < ActionMailer::Base
  default from: '"The Duke Girls" <service@mg.thedukegirls.com>',
          bcc: '"The Duke Girls" <service@mg.thedukegirls.com>'
  layout 'mailer'
end
