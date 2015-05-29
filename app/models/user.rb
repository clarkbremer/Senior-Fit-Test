class User < ActiveRecord::Base
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

end
