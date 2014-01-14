require "rubygems"
require "bundler/setup"

require 'gosu'

require './rectangle'
require './player'
require './enemy'
require './game_window'

window = GameWindow.new
window.show