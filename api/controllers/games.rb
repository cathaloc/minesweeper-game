Minesweeper::Api.controllers :games do
  
  get :tiles, map: '/games/:game_id/tiles' do
    @game = Game.first # TODO use id
    return if @game.blank?

    @tiles = @game.tiles

    render 'tiles/tiles'
  end

  post :dig_tile do
    return unless params[:x].present?
    return unless params[:y].present?

    game = Game.first

    @tiles = game.tiles.where({
      x: params[:x], 
      y: params[:y]
    })

    return if @tiles.blank?

    @tiles.first.dig
    render 'tiles/tiles'
  end  

end
