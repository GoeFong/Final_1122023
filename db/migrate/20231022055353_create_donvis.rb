class CreateDonvis < ActiveRecord::Migration[7.0]
  def change
    create_table :donvis do |t|
      t.string :ten
      t.string :country
      t.string :state
      t.string :city
      t.string :sdt
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
