class AddThemCbToCongviec < ActiveRecord::Migration[7.0]
  def change
    add_column :congviecs, :them_cb, :boolean, default: false
  end
end
