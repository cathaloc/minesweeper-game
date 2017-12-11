# Helper methods defined here can be accessed in any controller or view in the application

module Minesweeper
  class Api
    module GamesHelper
      # Digs a tile, returns all tiles nearby that are guaranteed
      # to be mine-less.
      def dig_tile(tile)
        recursively_dig_tiles([tile], [tile])
      end

      private

      def recursively_dig_tiles(tiles, all_tiles)
        return all_tiles if tiles.blank?

        tile_to_dig = tiles.pop
        nearby_mines = tile_to_dig.dig

        if nearby_mines == 0 && !tile_to_dig.is_mine?
          nearby_tiles = tile_to_dig.adjacent_tiles.where(is_dug: false)
          tiles.push(*nearby_tiles)
          all_tiles.push(*nearby_tiles)
        end

        recursively_dig_tiles(tiles, all_tiles)
      end
    end

    helpers GamesHelper
  end
end
