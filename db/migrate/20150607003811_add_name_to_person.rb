class AddNameToPerson < ActiveRecord::Migration
  def change
    add_column :residents, :name, :string
    add_column :assessors, :name, :string
    add_column :admins, :name, :string
  end
end
