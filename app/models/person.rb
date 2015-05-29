class Person < ActiveRecord::Base
  self.abstract_class = true
  has_one :user, as: :person, dependent: :destroy
  accepts_nested_attributes_for :user
  delegate :name, to: :user
  delegate :email, to: :user

end
