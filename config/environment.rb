# Load the Rails application.
require File.expand_path('../application', __FILE__)

Ideabank::Application.configure do
	config.action_mailer.delivery_method = :smtp
	config.action_mailer.raise_delivery_errors = true
	config.action_mailer.smtp_settings = {
	  :address              => "smtp.gmail.com",
	  :port                 => 587,
	  :domain               => 'gmail.com',
	  :user_name            => ENV["GMAIL_USERNAME"],
	  :password             => ENV["GMAIL_PASSWORD"],
	  :authentication       => :plain,
	  :enable_starttls_auto => true  }
end

# Initialize the Rails application.
 Ideabank::Application.initialize!

	
  #ActionMailer::Base.delivery_method = :sendmail
  #ActionMailer::Base.sendmail_settings = {
   #     :location       => '/usr/sbin/sendmail',
   #     :arguments      => '-i -t'
  #}

  #ActionMailer::Base.perform_deliveries = true # the "deliver_*" methods are available
  #ActionMailer::Base.raise_delivery_errors = true
