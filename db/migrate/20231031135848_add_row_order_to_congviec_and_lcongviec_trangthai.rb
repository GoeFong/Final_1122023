class AddRowOrderToCongviecAndLcongviecTrangthai < ActiveRecord::Migration[7.0]
  def change
    add_column :congviecs, :row_order, :integer
    add_column :lcongviec_trangthais, :row_order, :integer
  end
end
