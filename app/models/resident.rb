class Resident < Person
  belongs_to :community
  has_many :assessments, dependent: :destroy
end
