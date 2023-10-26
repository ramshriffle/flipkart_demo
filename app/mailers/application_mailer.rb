# frozen_string_literal: true

# application mailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'ramkrishnak@shriffle.com'
  layout 'mailer'
end
