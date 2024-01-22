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
class DonviUser < ApplicationRecord
  belongs_to :user
  belongs_to :donvi


  CHUCVU = [
    { label: "Trưởng phòng", gia_tri: "truong_phong" },
    { label: "Phó phòng", gia_tri: "pho_phong" },
    { label: "Nhân viên", gia_tri: "nhan_vien" }
  ].freeze
end
