class AddColPrefixCongviecToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :prefix_congviec, :string
  end
end
