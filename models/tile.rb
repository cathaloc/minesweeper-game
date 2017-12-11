class Tile < ActiveRecord::Base
  ##
  # Associations
  #
  belongs_to :game

  ##
  # Validations
  #
  validates_presence_of :game

  ##
  # Instance Methods
  #
  def dig
    self.update_column(:is_dug, true)
    nearby_mine_count
  end

  def nearby_mine_count
    self.adjacent_tiles.where(is_mine: true).count
  end

  def adjacent_tiles
    Tile.where({
      game: self.game,
      x: [self.x-1..self.x+1],
      y: [self.y-1..self.y+1],
    }).where.not({
      id: self.id
    })
  end

end
