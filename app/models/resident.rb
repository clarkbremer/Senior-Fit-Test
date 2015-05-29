class Resident < Person
  belongs_to :community
  has_many :assessments
end
