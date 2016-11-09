# Preview all emails at http://localhost:3000/rails/mailers/student_mailer
class StudentMailerPreview < ActionMailer::Preview
  def confirmation_mail_preview
    StudentMailer.confirmation_email(Student.first)
  end
end
