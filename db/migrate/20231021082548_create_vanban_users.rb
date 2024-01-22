class CreateVanbanUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :vanban_users do |t|
      t.references :vanban, null: false, foreign_key: { to_table: :vanbans, on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :role

      t.timestamps
    end
  end
end
