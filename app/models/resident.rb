class Resident < Person
  has_many :assessments, dependent: :destroy
  belongs_to :community
  has_one :assessor, dependent: :destroy

  validates_presence_of :community
  validates_presence_of :birthdate
  validates_presence_of :gender
  validates :gender, :inclusion => %w(Male Female)

  def name
    "#{first_name} #{last_name}"
  end

  def assessment_chart_data
    data = {}
    assessments.each do |assessment|
      data[assessment.date.to_s] = [assessment.chair_stand, assessment.arm_curl, assessment.two_minute_step, assessment.sit_and_reach, assessment.back_scratch, assessment.eight_foot_up_and_go]
    end
    data["tests"] = ['Chair stand', 'Arm curl', 'Two minute step', 'Sit and reach', 'Back scratch', 'Eight foot up and go']
    data.to_json
  end

private

end
