class AddBoardToCongviec < ActiveRecord::Migration[7.0]
  def change
    add_reference :congviecs, :board, null: true, foreign_key: true

  end
end
