Minesweeper::App.controllers :game do

  get :index do
    @game = Game.first
    @tiles = @game.tiles
    render 'game/game'
  end

end