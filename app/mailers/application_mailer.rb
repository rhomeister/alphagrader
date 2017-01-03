# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'ruben+alphgrader@fireservicerota.com'
  layout 'mailer'
end
