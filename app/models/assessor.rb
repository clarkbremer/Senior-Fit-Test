class Assessor < Person
  has_and_belongs_to_many :communities
  belongs_to :resident
  validates_presence_of :resident
  accepts_nested_attributes_for :resident
  delegate :name, to: :resident
  delegate :first_name, to: :resident
end
