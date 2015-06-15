class AddDetailsToResidents < ActiveRecord::Migration
  def change
    remove_column :admins, :name, :string
    add_reference :admins, :resident
    remove_column :assessors, :name, :string
    add_reference :assessors, :resident
    remove_column :residents, :name, :string
    add_column :residents, :first_name, :string
    add_column :residents, :last_name, :string
    add_column :residents, :gender, :string
    add_column :residents, :address1, :string
    add_column :residents, :address2, :string
    add_column :residents, :city, :string
    add_column :residents, :state, :string
    add_column :residents, :zip, :string
    add_column :residents, :phone, :string
  end
end
