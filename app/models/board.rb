# == Schema Information
#
# Table name: boards
#
#  id              :bigint           not null, primary key
#  name            :string
#  prefix_congviec :string
#  row_order       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Board < ApplicationRecord
  belongs_to :user
  has_many :congviecs, :dependent => :destroy
  # validates :prefix_congviec, presence: true
  include RankedModel
  ranks :row_order
  
  after_create_commit do
    broadcast_append_to "boards" , target: "boards" ,view:"boards/board", locals: { board: self}
  end
 
end
