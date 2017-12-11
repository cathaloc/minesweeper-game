Minesweeper::App.controllers :game do

  get :index, with: :id do
    logger.info("Naviagting to game id #{params[:id]}")
    @game = Game.find_by_id params[:id]
    return if @game.blank?

    @tiles = @game.tiles
    render '/game/game'
  end

  get :create, map: 'create_game' do
    render '/game/create'
  end
end