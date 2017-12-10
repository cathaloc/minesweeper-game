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
  end

  def nearby_mine_count
    count = Tile.where({
      game: self.game,
      x: [self.x-1..self.x+1],
      y: [self.y-1..self.y+1],
      is_mine: true
    }).count

    count -= 1 if self.is_mine?

    count
  end

end
