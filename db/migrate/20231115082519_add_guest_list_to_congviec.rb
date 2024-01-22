class AddGuestListToCongviec < ActiveRecord::Migration[7.0]
  def change
    add_column :congviecs, :guest_list, :string
  end
end
