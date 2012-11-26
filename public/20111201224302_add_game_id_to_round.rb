class AddGameIdToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :game_id, :integer
  end
end
