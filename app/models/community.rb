class Community < ActiveRecord::Base
  has_and_belongs_to_many :assessors
  has_many :residents

  validates_presence_of :name, :city, :state
end
