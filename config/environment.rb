# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#added as part of course to sned out emails
ActionMailer::Base.smtp_settings = {
  :port           =>  ENV['MAILGUN_SMTP_PORT'],
  :address        =>  ENV['MAILGUN_SMTP_SERVER'],
  :user_name      =>  ENV['MAILGUN_SMTP_LOGIN'],
  :password       =>  ENV['MAILGUN_SMTP_PASSWORD'],
  :authentication =>  :plain,
}
ActionMailer::Base.delivery_method = :smtp