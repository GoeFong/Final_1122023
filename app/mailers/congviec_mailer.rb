class CongviecMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.congviec_mailer.invite.subject
  #
  def invite
    @congviec = params[:congviec]
    @greeting = "Hi"
    calendar_event = Congviecs::IcalendarEvent.new(congviec: @congviec).call
    attachments['invite.ics'] = { mime_type: 'application/ics', content: calendar_event.to_ical }
    mail to: @congviec.users_cv.map(&:email),
    # mail to: "phongb1906397@student.ctu.edu.vn",
        subject: "#{@congviec.macongviec} | #{@congviec.board.name}"
  end
end
