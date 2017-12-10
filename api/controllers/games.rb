Minesweeper::Api.controllers :games do
  
  post :dig_tile do
    return unless params[:x].present?
    return unless params[:y].present?

    game = Game.first

    @tile = game.tiles.where({
      x: params[:x], 
      y: params[:y]
    }).first

    return if @tile.blank?

    @tile.dig
    render 'tiles/tile'
  end  

end
