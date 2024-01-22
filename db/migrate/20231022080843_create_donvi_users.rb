class CreateDonviUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :donvi_users do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :donvi, null: false, foreign_key: { to_table: :donvis, on_delete: :cascade }
      t.string :chucvu

      t.timestamps
    end
  end
end
