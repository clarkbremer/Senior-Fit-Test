class AddAssessorToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :assessor, :integer
    drop_table :admins
    add_column :residents, :admin, :boolean, default: false
    rename_column :users, :person_id, :resident_id
    remove_column :users, :person_type, :string
  end
end
