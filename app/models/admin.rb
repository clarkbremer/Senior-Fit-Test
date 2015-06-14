class Admin < Person
  belongs_to :resident
  validates_presence_of :resident
  accepts_nested_attributes_for :resident
  delegate :name, to: :resident
  delegate :first_name, to: :resident
end
