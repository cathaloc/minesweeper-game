class Game < ActiveRecord::Base
  ##
  # Associations
  #
  has_many :tiles, dependent: :destroy

  ##
  # Validations
  #
  validates_presence_of :name
  validates_inclusion_of :x_size, {in: 1..20}
  validates_inclusion_of :y_size, {in: 1..20}

  ##
  # Hooks
  #
  after_create :create_tiles

  def create_tiles
    # TODO Make configurable
    tiles = initialize_tile_objects
    set_random_tiles_as_mines(tiles, mine_count)
    
    Tile.import tiles
  end


  private


  def initialize_tile_objects
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
