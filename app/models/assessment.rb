class Assessment < ActiveRecord::Base
  belongs_to :resident
  validates_presence_of :resident
  validates_presence_of :date

  def percentiles
    result = []
    [ :arm_curl, :back_scratch, :chair_stand, :eight_foot_up_and_go, :sit_and_reach, :two_minute_step].each do |test|
      norm =  Norm.where(test: test, gender: resident.gender.downcase).where("max_age >= ?", resident.age).where("min_age <= ?", resident.age).first
      raw = self.send(test)
      result << norm.percentile(raw)
    end
    result
  end

end
