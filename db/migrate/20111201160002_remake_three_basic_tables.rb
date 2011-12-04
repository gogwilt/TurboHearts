# I super screwed up everything by dropping all the tables, so I combined
# the previous three migrations in order to make a single migration that I
# could run to restore everything to its proper point.
class RemakeThreeBasicTables < ActiveRecord::Migration
  def change
    # do nothing
  end
  
  def create_three_tables
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
    create_table :rounds do |t|
      t.integer :reporter_id

      t.timestamps
    end
    create_table :points do |t|
      t.integer :user_id
      t.integer :round_id
      t.integer :amount

      t.timestamps
    end
  end
end
