class Resident < Person
  has_many :assessments, dependent: :destroy
  belongs_to :community
  has_one :assessor, dependent: :destroy  # only if they are an assessor

  validates_presence_of :community
  validates_presence_of :birthdate
  validates_presence_of :gender
  validates :gender, :inclusion => %w(male female)
  validate :age_range

  def name
    "#{first_name} #{last_name}"
  end

  def assessment_chart_data
    data = {}
    assessments.each do |assessment|
      data[assessment.date.to_s] = assessment.percentiles
    end
    data["tests"] = ['Chair stand', 'Arm curl', 'Two minute step', 'Sit and reach', 'Back scratch', 'Eight foot up and go']
    data.to_json
  end

  def has_assessments?
    self.assessments.any?
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def is_assessor?
    assessor.present?
  end

private
  def age_range
    if self.age < 65 || self.age > 94
      errors.add(:birthday, "Must be between 65 and 94 years of age.")
    end
  end
end
