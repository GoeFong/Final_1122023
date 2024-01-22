class AddDonViToVanban < ActiveRecord::Migration[7.0]
  def change
    add_reference :vanbans, :donvi, null: false, foreign_key: true
  end
end
