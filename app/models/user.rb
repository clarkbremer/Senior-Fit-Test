class User < ActiveRecord::Base
  belongs_to :person, polymorphic: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  def admin?
    self.person_type == "Admin"
  end

  def assessor?
    self.person_type == "Assessor" || self.person_type == "Admin"
  end

  def resident?
    self.person_type == "Resident" || self.person_type == "Assessor" || self.person_type == "Admin"
  end

  def assessor_for_resident?(resident)
    return false unless assessor?
    assessor = self.person
    assessor.communities.include? resident.community
  end

  def assessor_for_community?(community)
    return false unless assessor?
    assessor = self.person
    assessor.communities.include? community
  end
end
