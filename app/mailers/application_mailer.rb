class ApplicationMailer < ActionMailer::Base
  default from: '"The Duke Girls" <jill@chiocciola.de>',
          bcc: '"The Duke Girls" <jill@chiocciola.de>'
  layout 'mailer'
end
