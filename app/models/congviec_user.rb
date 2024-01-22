# == Schema Information
#
# Table name: congviec_users
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  congviec_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_congviec_users_on_congviec_id  (congviec_id)
#  index_congviec_users_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (congviec_id => congviecs.id)
#  fk_rails_...  (user_id => users.id)
#
class CongviecUser < ApplicationRecord
  belongs_to :user
  belongs_to :congviec
  has_rich_text :ghichu

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: "Notification"

  def self.ransackable_attributes(auth_object = nil)
    ["congviec_id", "created_at", "id", "updated_at", "user_id", "vanban_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["congviec", "rich_text_ghichu", "user", "vanban"]
  end

  private  

  def notify_recipient
    CongviecuserNotification.with(congviecuser: self, congviec: congviec).deliver_later(self.user)
    self.congviec.edit_google_event(self.congviec)
  end

  def cleanup_notifications
    notifications_as_congviec_user.destroy_all
  end

end
