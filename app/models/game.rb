class Game < ActiveRecord::Base
  ##
  # Associations
  #
  has_many :tiles

  ##
  # Validations
  #
  validates_presence_of :name
  # TODO validate that it has all tiles

  ##
  # Hooks
  #
  after_create :create_tiles

  def create_tiles
    # TODO Make configurable
    x_size = 10
    y_size = 10
    mine_count = 10

    tiles = initialize_tile_objects(x_size, y_size)
    set_random_tiles_as_mines(tiles, mine_count)
    
    Tile.import tiles
  end


  private


  def initialize_tile_objects(x_size, y_size)
    tiles = []
    x_size.times do |x|
      y_size.times do |y|
        tiles << Tile.new({
          game: self,
          x: x,
          y: y
        })
      end
    end

    tiles
  end

  def set_random_tiles_as_mines(tiles, total_mine_count)
    raise Exception("This game has too many mines") if total_mine_count >= tiles.count
    
    mines_set = 0
    
    until mines_set >= total_mine_count
      tile_to_set = tiles.sample
      next if tile_to_set.is_mine?

      tile_to_set.is_mine = true
      mines_set += 1
    end
  end
end
