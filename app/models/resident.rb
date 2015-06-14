class Resident < Person
  has_many :assessments, dependent: :destroy
  belongs_to :community
  validates_presence_of :community
  validates_presence_of :birthdate

  def name
    "#{first_name} #{last_name}"
  end
end
