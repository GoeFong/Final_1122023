class CreateCongviecUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :congviec_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :congviec, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
