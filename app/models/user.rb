class User < ActiveRecord::Base
  belongs_to :resident
  # validates_presence_of :resident

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  delegate :is_admin?, to: :resident
  delegate :is_assessor?, to: :resident
  delegate :assessor_for_resident?, to: :resident
  delegate :assessor_for_community?, to: :resident
end
