# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Ideabank::Application.initialize!

  ActionMailer::Base.delivery_method = :sendmail
  ActionMailer::Base.sendmail_settings = {
        :location       => '/usr/sbin/sendmail',
        :arguments      => '-i -t'
  }

  ActionMailer::Base.perform_deliveries = true # the "deliver_*" methods are available
  ActionMailer::Base.raise_delivery_errors = true
