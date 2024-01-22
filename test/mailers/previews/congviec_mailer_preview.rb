# Preview all emails at http://localhost:3000/rails/mailers/congviec_mailer
class CongviecMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/congviec_mailer/invite
  def invite
    CongviecMailer.with(congviec: Congviec.first).invite
  end

end
