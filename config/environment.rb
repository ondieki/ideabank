# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Ideabank::Application.initialize!

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = "utf-8"