class CreateVanbans < ActiveRecord::Migration[7.0]
  def change
    create_table :vanbans do |t|
      t.string :link_to_apply
      t.string :title
      t.string :level
      t.string    :loaivanban
      t.datetime  :published_at
      t.string        :status,    default: ("cho_xu_ly")
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
