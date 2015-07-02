class RenameAssessorId < ActiveRecord::Migration
  def change
    rename_column :assessments, :assessor, :assessor_id
  end
end
