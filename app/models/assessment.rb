class Assessment < ActiveRecord::Base
  belongs_to :resident
  belongs_to :assessor
  validates_presence_of :resident
  validates_presence_of :date
  before_save :calculate_percentiles

  def percentiles
    [
      chair_stand_percentile,
      arm_curl_percentile,
      two_minute_step_percentile,
      sit_and_reach_percentile,
      back_scratch_percentile,
      eight_foot_up_and_go_percentile
    ]
  end

  private

  def calculate_percentiles
    [ :arm_curl, :back_scratch, :chair_stand, :eight_foot_up_and_go, :sit_and_reach, :two_minute_step].each do |test|
      norm =  Norm.where(test: test, gender: resident.gender).where("max_age >= ?", resident.age).where("min_age <= ?", resident.age).first
      raw = self.send(test)
      self.send("#{test}_percentile=", norm.percentile(raw))
    end
  end

end
