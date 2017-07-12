require './lib/rectangle'
require './lib/player'
require './lib/enemy'
require './lib/game_window'

module RectangleDodger

  class Game
    WIDTH = 640
    HEIGHT = 480

    attr_reader :level, :player, :enemies, :state, :score

    def initialize(player_x, player_y)
      @player = Player.new(player_x, player_y)
      @enemies = create_enemies
      @level = 1
      @state = :play
      @score = 0
    end

    def update_score
      @score += level * enemies.count
    end

    def update_enemies
      update_enemies_position
      update_enemies_existance
    end

    def update_player(x, y)
      @player.x = x
      @player.y = y
    end

    def detect_collisions
      @enemies.each do |enemy|
        if check_collision(@player, enemy)
          @state = :game_over
        end
      end
    end

    private

    def create_enemies
      if level == 1
        Array.new(5) { LeftToRightSinus.new(HEIGHT) }
      elsif level == 2
        Array.new(20) { LeftToRightSinus.new(HEIGHT) }
      elsif level == 3
        Array.new(10) { LeftToRight.new(HEIGHT, rand(10) + 2) }
      elsif level == 4
        Array.new(20) { LeftToRight.new(HEIGHT, rand(12) + 3) }
      elsif level == 5
        Array.new(30) { LeftToRight.new(HEIGHT, rand(9) + 6) }
      else
        Array.new(60) { LeftToRightFollower.new(HEIGHT, @player) }
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
