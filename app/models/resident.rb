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
      data[assessment.date.to_s] = assessment.percentiles
      puts "Percentiles: #{assessment.percentiles.inspect}"
    end
    data["tests"] = ['Chair stand', 'Arm curl', 'Two minute step', 'Sit and reach', 'Back scratch', 'Eight foot up and go']
    data.to_json
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

private

end
