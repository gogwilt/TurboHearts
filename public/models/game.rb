class Game < ActiveRecord::Base
  has_many :rounds

  belongs_to :player1, :class_name => "User"
  belongs_to :player2, :class_name => "User"
  belongs_to :player3, :class_name => "User"
  belongs_to :player4, :class_name => "User"
  
  validates_presence_of :player1
  validates_presence_of :player2
  validates_presence_of :player3
  validates_presence_of :player4
  
  def score(player)
    player_points = self.rounds.map do |round| 
      round.points.find_by_user_id(player.id)
    end
    player_points.reduce(0) do |sum, value|
      sum + value.amount
    end
  end
end
