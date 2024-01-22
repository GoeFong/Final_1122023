class AddIndexMacongviecToCongviec < ActiveRecord::Migration[7.0]
  def change
    add_index :congviecs, :macongviec, unique: true
  end
end
