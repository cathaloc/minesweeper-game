Minesweeper::App.controllers :game do

  get :index, with: :id do
    @game = Game.find_by_id params[:id]
    return if @game.blank?

    @tiles = @game.tiles
    render '/game/game'
  end

  get :create, map: 'create_game' do
    render '/game/create'
  end
end