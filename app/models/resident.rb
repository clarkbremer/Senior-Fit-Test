class Resident < Person
  has_many :assessments, dependent: :destroy
  belongs_to :community

  validates_presence_of :community
  validates_presence_of :birthdate
  validates_presence_of :gender
  validates :gender, :inclusion => %w(Male Female)

  def name
    "#{first_name} #{last_name}"
  end

private

end
