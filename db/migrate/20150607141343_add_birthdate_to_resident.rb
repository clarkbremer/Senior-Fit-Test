class AddBirthdateToResident < ActiveRecord::Migration
  def change
    add_column :residents, :birthdate, :date
  end
end
