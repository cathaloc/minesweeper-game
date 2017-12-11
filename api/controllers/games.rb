Minesweeper::Api.controllers :games do
  
  get :tiles, map: '/games/:game_id/tiles' do
    @game = Game.find_by_id params[:game_id]
    return if @game.blank?

    @tiles = @game.tiles

    render 'tiles/tiles'
  end

  post :dig_tile, map: '/games/:game_id/dig_tile' do
    return unless params[:x].present?
    return unless params[:y].present?

    @game = Game.find_by_id params[:game_id]
    return if @game.blank?

    tile_to_dig = Tile.where(game: @game, x: params[:x], y: params[:y]).first
    return if tile_to_dig.blank?

    @tiles = dig_tile(tile_to_dig)

    render 'tiles/tiles'
  end  

end
