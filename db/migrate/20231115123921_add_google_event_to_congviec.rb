class AddGoogleEventToCongviec < ActiveRecord::Migration[7.0]
  def change
    add_column :congviecs, :google_event_id, :string
  end
end
