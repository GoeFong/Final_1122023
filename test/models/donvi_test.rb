# == Schema Information
#
# Table name: donvis
#
#  id         :bigint           not null, primary key
#  city       :string
#  country    :string
#  email      :string
#  sdt        :string
#  state      :string
#  status     :string
#  ten        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class DonviTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
