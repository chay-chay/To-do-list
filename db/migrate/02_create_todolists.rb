class CreateTodolists < ActiveRecord::Migration
  def change
    create_table :todolists do |t|
      t.string :todo
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
