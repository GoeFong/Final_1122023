require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

module GoogleCalendarApi

  include ActiveSupport::Concern

  def get_google_calendar_client(current_user)
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)

    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => current_user.access_token,
        "refresh_token" => current_user.refresh_token,
        "client_id" => ENV['GOOGLE_OAUTH_CLIENT_ID'],
        "client_secret" => ENV['GOOGLE_OAUTH_CLIENT_SECRET']
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if current_user.expired?
        client.authorization.refresh!
        current_user.update(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      puts e.message
    end
    client
  end

  def create_google_event(event)
    # byebug
    client = get_google_calendar_client(event.user_giamsat)
    g_event = get_event(event)
    ge = client.insert_event(Congviec::CALENDAR_ID, g_event)
    event.update(google_event_id: ge.id)
  end

  def add_quick_google_event(event, user)
    client = get_google_calendar_client user
    ge = client.quick_add_event(Congviec::CALENDAR_ID, event.title)
    event.update(google_event_id: ge.id)
  end

  def edit_google_event(event)
    client = get_google_calendar_client(event.user_giamsat)
    g_event = client.get_event(Congviec::CALENDAR_ID, event.google_event_id)
    ge = get_event(event)
    client.update_event(Congviec::CALENDAR_ID, event.google_event_id, ge)
  end

  def get_event(event)
    event = Google::Apis::CalendarV3::Event.new(
      summary: "Lịch công việc #{event.macongviec} ",
      location: event.diachi,
      description: "Xem #{event.macongviec} trực tiếp tại #{event.url_congviec} \n Mô tả: \n #{event.noidung}",
      start: {
        date_time: event.ngay_bd.to_datetime.to_s,
        time_zone: 'Asia/Ho_Chi_Minh', 
      },
      end: {
        date_time: event.ngay_kt.to_datetime.to_s,
        time_zone: 'Asia/Ho_Chi_Minh',
      },
      organizer: {
        email: event.user_giamsat.email, 
        displayName: event.user_giamsat.name
      },
      attendees: event_attendees(event),
      reminders: {
        use_default: false
      },
      sendNotifications: true,
      sendUpdates: 'all'
    )
   
  end

  def delete_google_event(event)
    # byebug
    client = get_google_calendar_client(event.user_giamsat)
    client.delete_event(Congviec::CALENDAR_ID, event.google_event_id)
  end

  def get_google_event(event_id, user)
    client = get_google_calendar_client user
    g_event = client.get_event(Congviec::CALENDAR_ID, event_id)
  end

  def event_attendees(event)
    event.email_guest_list.map {|guest| { email: guest, displayName: guest.split('@')[0], organizer: false }} << { email: event.user_giamsat.email, displayName: event.user_giamsat.name, organizer: true}
  end

end
