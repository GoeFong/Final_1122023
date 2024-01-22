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
require "test_helper"

class CongviecUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
