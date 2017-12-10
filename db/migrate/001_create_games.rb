class CreateGames < ActiveRecord::Migration[4.2]
  def self.up
    create_table :games do |t|
      t.string 	:name
      t.integer :x_size, default: 5
      t.integer :y_size, default: 5
      t.integer :mine_count, default: 5
      t.timestamps
    end
  end

  def self.down
  	drop_table :games
  end
end
