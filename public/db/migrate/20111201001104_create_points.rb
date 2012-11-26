class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :user_id
      t.integer :round_id
      t.integer :amount

      t.timestamps
    end
  end
end
