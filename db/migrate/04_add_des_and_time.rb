class AddDesAndTime < ActiveRecord::Migration
  def change
    add_column :todolists, :time, :string
    add_column :todolists, :description, :string
  end
end
