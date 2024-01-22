# Congviecs::IcalendarEvent.new(congviec: Congviec.first).call
class Congviecs::IcalendarEvent
    require 'icalendar'
    include Rails.application.routes.url_helpers

    def initialize(congviec:)
        @congviec = congviec
    end
    def call
        # # Create a calendar with an event (standard method)
        # cal = Icalendar::Calendar.new
        # cal.event do |e|
        # e.dtstart     = @congviec.ngay_bd
        # e.dtend       = @congviec.ngay_kt
        # e.summary     = "Lịch công việc #{@congviec.macongviec} | #{@congviec.board.name}"
        # e.description = "#{Nokogiri::HTML.parse(@congviec.noidung.body.to_s).text}\n\n" +
        # "To accept this invitation, click the link below:\n" +
        # "#{board_congviec_url(@congviec.board, @congviec)}"
        # e.ip_class    = "PUBLIC"
        # e.location    = @congviec.diachi
        # e.uid = "congviecid:#{@congviec.id.to_s}"
        # e.sequence = Time.now.to_i
        # e.url = board_congviec_url(@congviec.board,@congviec)
        # e.organizer = Icalendar::Values::CalAddress.new("mailto:#{ApplicationMailer.default_params[:from]}", cn: 'Trần Thanh Phong')
        # e.attendee = Icalendar::Values::CalAddress.new("mailto:phongb1906397@student.edu.ctu.vn", partstat: 'ACCEPTED')
        
        # end
        # cal.publish
        # cal.to_ical
    # end

        ical = ::Icalendar::Calendar.new
        event = ::Icalendar::Event.new
        event.dtstart = Icalendar::Values::DateTime.new @congviec.ngay_bd
        event.dtend = Icalendar::Values::DateTime.new @congviec.ngay_kt
        event.summary = "Lịch công việc #{@congviec.macongviec} | #{@congviec.board.name}"
        event.description = "Xem #{@congviec.macongviec} trực tiếp tại at #{board_congviec_url(@congviec.board, @congviec)}"
        event.uid =  "congviecid:#{@congviec.id.to_s}" # important for updating/canceling an event
        event.sequence = Time.now.to_i # important for updating/canceling an event
        event.url = "#{board_congviec_url(@congviec.board, @congviec)}"
        event.location = @congviec.diachi # location on map
        # event.attendee = %w(mailto:abc@example.com mailto:xyz@example.com)
        if @congviec.users_cv.present?
            @congviec.users_cv.each do |user|
                attendee_value = Icalendar::Values::CalAddress.new("mailto:#{user.email}", partstat: 'ACCEPTED', rsvp: true, 'x-num-guests' => 0) 
                event.append_attendee(attendee_value)# DECLINED # TENTATIVE
            end
        end
        # event.organizer = "mailto:organizer@example.com"
        event.organizer = Icalendar::Values::CalAddress.new("mailto:#{ApplicationMailer.default_params[:from]}", cn: 'Trần Thanh Phong')
        event.status = 'CONFIRMED' # 'CANCELLED'
        event.ip_class = 'PUBLIC' # 'PRIVATE'
        event.transp = 'OPAQUE'
        # event.attach = Icalendar::Values::Uri.new @url
        # event.append_attach = Icalendar::Values::Uri.new(@url, "fmttype" => "application/binary")
        event.created = @congviec.created_at
        event.last_modified = @congviec.updated_at

        event.alarm do |a|
        a.summary = "#{@congviec.macongviec} starts in 30 minutes!"
        a.trigger = '-PT30M'
        end

        ical.add_event(event)
        ical.append_custom_property('METHOD', 'REQUEST') # add event to calendar by default!
        ical.publish
        ical.ip_method = 'REQUEST'
        # ical.ip_method = 'PUBLISH'
        # ical.ip_method = 'CANCEL'
        ical
    end
end