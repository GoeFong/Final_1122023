class AddSlugToVanbans < ActiveRecord::Migration[7.0]
  def change
    add_column :vanbans, :slug, :string
    add_index :vanbans, :slug, unique: true
  end
end
