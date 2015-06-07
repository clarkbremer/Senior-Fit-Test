class Person < ActiveRecord::Base
  self.abstract_class = true
  has_one :user, as: :person, dependent: :destroy
  accepts_nested_attributes_for :user

  validates_presence_of :name
end
