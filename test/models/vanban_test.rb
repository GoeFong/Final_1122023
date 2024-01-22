# == Schema Information
#
# Table name: vanbans
#
#  id            :bigint           not null, primary key
#  level         :string
#  link_to_apply :string
#  loaivanban    :string
#  published_at  :datetime
#  slug          :string
#  status        :string           default("cho_xu_ly")
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  donvi_id      :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_vanbans_on_donvi_id  (donvi_id)
#  index_vanbans_on_slug      (slug) UNIQUE
#  index_vanbans_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (donvi_id => donvis.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class VanbanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
