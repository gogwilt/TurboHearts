class User < ActiveRecord::Base
  has_many :points
  has_many :rounds, :through => :points
  has_many :games, :through => :rounds
  
  validates_presence_of :name
end
