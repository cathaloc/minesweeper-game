class CreateTiles < ActiveRecord::Migration[4.2]
  def self.up
    create_table :tiles do |t|
      t.integer	:x
      t.integer :y
      t.integer :game_id
      t.boolean :mine
    end
  end

  def self.down
  	drop_table :tiles
  end
end
