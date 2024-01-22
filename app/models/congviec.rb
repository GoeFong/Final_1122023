# == Schema Information
#
# Table name: congviecs
#
#  id                     :bigint           not null, primary key
#  diachi                 :string
#  guest_list             :string
#  macongviec             :string
#  ngay_bd                :datetime
#  ngay_kt                :datetime
#  row_order              :integer
#  status                 :boolean          default(FALSE)
#  them_cb                :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  board_id               :bigint
#  google_event_id        :string
#  lcongviec_trangthai_id :bigint           not null
#  user_id                :bigint           not null
#  vanban_id              :bigint
#
# Indexes
#
#  index_congviecs_on_board_id                (board_id)
#  index_congviecs_on_lcongviec_trangthai_id  (lcongviec_trangthai_id)
#  index_congviecs_on_macongviec              (macongviec) UNIQUE
#  index_congviecs_on_user_id                 (user_id)
#  index_congviecs_on_vanban_id               (vanban_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#  fk_rails_...  (lcongviec_trangthai_id => lcongviec_trangthais.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (vanban_id => vanbans.id)
#
class Congviec < ApplicationRecord

  # require 'icalendar'
  include Rails.application.routes.url_helpers
  include GoogleCalendarApi
  CALENDAR_ID = 'primary'
  validates :diachi, presence: true
  after_create_commit do
    broadcast_append_to "congviecs" , target: "all-congviecs-#{self.board_id}" ,view:"congviecs/congviec", locals: {congviec: self, board: self.board_id, stt: "Mới"}
  end
  after_create :publish_event_to_gcal
  after_update :update_event_on_gcal
  before_destroy :remove_event_from_gcal

  belongs_to :vanban, optional: true 
  belongs_to :lcongviec_trangthai
  belongs_to :board, optional: true 
  belongs_to :user_giamsat,  class_name: 'User', foreign_key: 'user_id'

  has_many :congviec_users, dependent: :destroy
  has_many :users_cv, through: :congviec_users , source: :user
  has_many :vanbans_cv, through: :congviec_users , source: :vanban
  has_noticed_notifications model_name: "Notification"
  has_many :notifications, through: :user_giamsat, dependent: :destroy

  has_rich_text :noidung

  # scope :email_cv, ->(q) { where("text(email_cv) ILIKE '' " )}

  include RankedModel
  ranks :row_order, with_same: :board_id
  def self.ransackable_attributes(auth_object = nil)
    ["board_id", "created_at", "diachi", "google_event_id", "guest_list", "id", "lcongviec_trangthai_id", "macongviec", "ngay_bd", "ngay_kt", "row_order", "status", "them_cb", "updated_at", "user_id", "vanban_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["board", "congviec_users", "lcongviec_trangthai", "notifications", "rich_text_noidung", "user_giamsat", "users_cv", "vanban", "vanbans_cv"]
  end
  def self.ransackable_methods(auth_object = nil)
    ["email_guest_list"] 
  end
  def email_guest_list
    if self.guest_list.nil?
      return if self.users_cv.map(&:email).nil? 
       self.users_cv.map(&:email)
    else 
      list =  guest_list.split(", ")
      return if self.users_cv.map(&:email).nil? 
        self.users_cv.map(&:email) | list 
    end
  end
  def email_guest
    return if self.guest_list.nil? 
        self.guest_list
     guest_list.split(", ")
  end
  def publish_event_to_gcal
    self.create_google_event(self)
  end

  def update_event_on_gcal
    self.edit_google_event(self)
  end

  def remove_event_from_gcal
    self.delete_google_event(self)
  end
  def url_congviec
    if self.board.present?
    board_congviec_url(self.board, self)
    else
    show_congviec_url(self)

    end
  end
end
