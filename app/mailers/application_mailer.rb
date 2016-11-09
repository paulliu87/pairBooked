class ApplicationMailer < ActionMailer::Base
  default from: 'paul.pliu87@gmail.com'
  layout 'mailer'
end

class StudentMailer < ApplicationMailer
end
