class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :round
  validates_presence_of :user
  validates_presence_of :round
  validates_presence_of :amount
end
