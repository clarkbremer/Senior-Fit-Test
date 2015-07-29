class Resident < ActiveRecord::Base
  has_one :user, dependent: :destroy
  accepts_nested_attributes_for :user
  has_many :assessments, dependent: :destroy
  belongs_to :community
  has_one :assessor, dependent: :destroy  # only if they are an assessor

  validates_presence_of :community
  validates_presence_of :birthdate
  validates_presence_of :gender
  validates :gender, :inclusion => %w(male female)
  #validate :age_range

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

  def age_for_norms
    actual_age = age
    return 94 if actual_age > 94
    return 65 if actual_age < 65
    return actual_age
  end

  def is_assessor?
    assessor.present?
  end

  def is_admin?
    self.admin
  end

  def assessor_for_resident?(other_resident)
    return true if is_admin?
    return false unless is_assessor?
    assessor = self.assessor
    assessor.communities.include? other_resident.community
  end

  def assessor_for_community?(community)
    return true if is_admin?
    return false unless is_assessor?
    assessor = self.assessor
    assessor.communities.include? community
  end

private
  def age_range
    if self.age < 65 || self.age > 94
      errors.add(:birthday, "Must be between 65 and 94 years of age.")
    end
  end
end
