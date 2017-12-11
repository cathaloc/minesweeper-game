module Minesweeper
  class Api < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers
    enable :sessions

    set :protect_from_csrf, false

    # All API endpoints will serve JSON.
    before do
      content_type 'application/json'
    end

  end
end
