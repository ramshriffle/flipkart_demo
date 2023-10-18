# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ramkrishnak@shriffle.com'
  layout 'mailer'
end
