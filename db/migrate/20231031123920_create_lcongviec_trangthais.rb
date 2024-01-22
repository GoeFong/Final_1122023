class CreateLcongviecTrangthais < ActiveRecord::Migration[7.0]
  def change
    create_table :lcongviec_trangthais do |t|
      t.string :label
      t.string :gia_tri
      t.string :color

      t.timestamps
    end
  end
end
