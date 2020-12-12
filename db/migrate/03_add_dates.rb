class AddDates < ActiveRecord::Migration
  def change
    add_column :todolists, :date, :string
  end
end
