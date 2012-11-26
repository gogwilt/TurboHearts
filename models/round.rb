class Round < ActiveRecord::Base
  has_many :points
  has_many :users, :through => :points
  belongs_to :reporter, :class_name => "User"
  belongs_to :game
  
  validates_presence_of :reporter
  validates_presence_of :game
end
