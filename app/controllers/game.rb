Minesweeper::App.controllers :game do

  get :index do
    @game = Game.first
    @tiles = @game.tiles
    render '/game/game'
  end

  get :index, with: :id do
    @game = Game.find_by_id params[:id]

    redirect :create if @game.blank?

    @tiles = @game.tiles
    render '/game/game'
  end

end