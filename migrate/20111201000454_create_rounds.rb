class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :reporter_id

      t.timestamps
    end
  end
end
