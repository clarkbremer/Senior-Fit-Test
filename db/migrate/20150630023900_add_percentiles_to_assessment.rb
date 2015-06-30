class AddPercentilesToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :chair_stand_percentile, :integer
    add_column :assessments, :arm_curl_percentile, :integer
    add_column :assessments, :two_minute_step_percentile, :integer
    add_column :assessments, :sit_and_reach_percentile, :integer
    add_column :assessments, :back_scratch_percentile, :integer
    add_column :assessments, :eight_foot_up_and_go_percentile, :integer
  end
end
