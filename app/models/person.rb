class Person < ActiveRecord::Base
  self.abstract_class = true
  has_one :user, as: :person
  accepts_nested_attributes_for :user

end
