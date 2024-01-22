class AddLcongviecTrangthaiToCongviec < ActiveRecord::Migration[7.0]
  def change
    add_reference :congviecs, :lcongviec_trangthai, null: false, foreign_key: true
  end
end
