# == Schema Information
#
# Table name: donvi_users
#
#  id         :bigint           not null, primary key
#  chucvu     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  donvi_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_donvi_users_on_donvi_id  (donvi_id)
#  index_donvi_users_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (donvi_id => donvis.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require "test_helper"

class DonviUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
