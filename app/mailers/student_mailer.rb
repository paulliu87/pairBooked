class StudentMailer < ApplicationMailer
  default from: 'paul.pliu87@gmail.com'

  def confirmation_email(student)
    @student = student
    p @student
    # @url  = 'http://example.com/login'
    mail(to: @student.email, subject: 'Confirmation')
  end
end
