class Resident < Person
  has_many :assessments, dependent: :destroy
  belongs_to :community
  validates_presence_of :community
end
