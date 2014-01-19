require "rubygems"
require "bundler/setup"

require 'gosu'

require './lib/rectangle'
require './lib/player'
require './lib/enemy'
require './lib/game_window'

window = GameWindow.new
window.show