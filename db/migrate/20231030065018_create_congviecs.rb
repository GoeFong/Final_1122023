class CreateCongviecs < ActiveRecord::Migration[7.0]
  def change
    create_table :congviecs do |t|
      t.string :macongviec
      t.datetime :ngay_bd
      t.datetime :ngay_kt
      t.string :diachi
      t.boolean :status, default: false 
      t.references :vanban, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
