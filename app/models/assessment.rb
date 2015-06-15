class Assessment < ActiveRecord::Base
  belongs_to :resident
  validates_presence_of :resident
  validates_presence_of :date

end
