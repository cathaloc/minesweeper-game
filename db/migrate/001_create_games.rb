class CreateGames < ActiveRecord::Migration[4.2]
  def self.up
    create_table :games do |t|
      t.string 	:name
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
  	drop_table :games
  end
end
