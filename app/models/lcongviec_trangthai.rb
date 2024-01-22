# == Schema Information
#
# Table name: lcongviec_trangthais
#
#  id         :bigint           not null, primary key
#  color      :string
#  gia_tri    :string
#  label      :string
#  row_order  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LcongviecTrangthai < ApplicationRecord
    # after_update_commit { broadcast_replace_to "lcongviec_trangthais"}
    has_many :congviecs

    include RankedModel
    ranks :row_order


    def self.ransackable_attributes(auth_object = nil)
        ["color", "created_at", "gia_tri", "id", "label", "row_order", "updated_at"]
    end
end
