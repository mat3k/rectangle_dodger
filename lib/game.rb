require './lib/rectangle'
require './lib/player'
require './lib/game_window'

require './lib/enemy/base'
require './lib/enemy/straight'
require './lib/enemy/sinusoid'
require './lib/enemy/follower'

module RectangleDodger
  class Game
    WIDTH = 640
    HEIGHT = 480

    attr_reader :level, :player, :enemies, :state, :score

    def initialize(player_x, player_y)
      @player = Player.new(player_x, player_y)
      @level = 1
      @state = :play
      @score = 0
      @enemies = create_enemies
    end

    def update_score
      @score += level * enemies.count
    end

    def update_enemies
      update_enemies_position
      update_enemies_existance
    end

    def update_player_position(x, y)
      player_x =
        if (x < 0)
          0
        elsif (x + player.width > WIDTH)
          WIDTH - player.width
        else
          x
        end

      player_y =
        if (y < 0)
          0
        elsif (y + player.height > HEIGHT)
          HEIGHT - player.height
        else
          y
        end
      player.set_position(player_x, player_y)
    end

    def detect_collisions
      enemies.each do |enemy|
        if check_collision(player, enemy)
          @state = :game_over
        end
      end
    end

    private

    def create_enemies
      if level == 1
        Array.new(5) { Enemy::Straight.new(HEIGHT) }
      elsif level == 2
        Array.new(20) { Enemy::Sinusoid.new(HEIGHT) }
      elsif level == 3
        Array.new(10) { |counter| Enemy::Straight.new(HEIGHT, 8 + counter * 0.7) }
      elsif level == 4
        Array.new(20) { |counter| Enemy::Straight.new(HEIGHT, 9 + counter * 0.5) }
      elsif level == 5
        Array.new(30) { |counter| Enemy::Straight.new(HEIGHT, 10 + counter * 0.3) }
      else
        Array.new(50) { Enemy::Follower.new(HEIGHT, player) }
      end
    end

    def update_enemies_position
      enemies.each do |enemy|
        enemy.tick
      end
    end

    def update_enemies_existance
      enemies_left = enemies.select do |enemy|
        enemy.left > 0 and enemy.right < WIDTH and enemy.top > 0 and enemy.bottom < HEIGHT
      end

      if enemies_left.empty?
        @level += 1
        @enemies = create_enemies
      end
    end

    def check_collision(a, b)
      ! (b.left > a.right or b.right < a.left or b.top > a.bottom or b.bottom < a.top)
    end
  end

  def self.run
    RectangleDodger::GameWindow.new.show
  end
end
