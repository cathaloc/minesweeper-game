Minesweeper::App.controllers :game do

  get :index do
    @game = Game.first
    render 'game/game'
  end

end