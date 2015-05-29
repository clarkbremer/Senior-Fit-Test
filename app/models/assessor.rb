class Assessor < Person
  has_and_belongs_to_many :communities
end
