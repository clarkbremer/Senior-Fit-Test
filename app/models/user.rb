class User < ActiveRecord::Base
  enum role: [:resident, :assessor, :admin]
  #after_initialize :set_default_role, :if => :new_record?
  belongs_to :person, polymorphic: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    self.person_type == "Admin"
  end

  def assessor?
    self.person_type == "Assessor" || self.person_type == "Admin"
  end

  def resident?
    self.person_type == "Resident" || self.person_type == "Assessor" || self.person_type == "Admin"
  end

  private

  def set_default_role
    self.role = self.person_type.to_s.downcase
  end
end
