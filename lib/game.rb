require './lib/rectangle'
require './lib/player'
require './lib/enemy'
require './lib/game_window'

module RectangleDodger

  def self.run
    RectangleDodger::GameWindow.new.show
  end

end