# == Schema Information
#
# Table name: vanban_users
#
#  id         :bigint           not null, primary key
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  vanban_id  :bigint           not null
#
# Indexes
#
#  index_vanban_users_on_user_id    (user_id)
#  index_vanban_users_on_vanban_id  (vanban_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#  fk_rails_...  (vanban_id => vanbans.id) ON DELETE => cascade
#
require "test_helper"

class VanbanUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
