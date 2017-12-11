module Minesweeper
  class App < Padrino::Application
    register ScssInitializer
    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers
    enable :sessions

    get '/' do
      redirect '/create_game'
    end

  end
end
