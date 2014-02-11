module RectangleDodger

  class GameWindow < Gosu::Window

    include RectangleDodger

    TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
    BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

    WIDTH = 640
    HEIGHT = 480

    PLAYER_WIDTH = 10
    PLAYER_HEIGHT = 10

    def initialize
      super WIDTH, HEIGHT, false
      self.caption = "Rectangle Dodger"
      init_fonts
      start_game
    end

    def create_enemies
      if @turn == 0
        Array.new(5) { LeftToRightSinus.new(HEIGHT) }
      elsif @turn == 1
        Array.new(20) { LeftToRightSinus.new(HEIGHT) }
      elsif @turn == 1
        Array.new(10) { LeftToRight.new(HEIGHT, rand(10) + 2) }
      elsif @turn == 2
        Array.new(20) { LeftToRight.new(HEIGHT, rand(12) + 3) }
      elsif @turn == 3
        Array.new(30) { LeftToRight.new(HEIGHT, rand(9) + 6) }
      else
        Array.new(60) { LeftToRightFollower.new(HEIGHT, @player) }
      end
    end

    def init_fonts
      @fonts = {}
      @fonts['score'] = Gosu::Font.new(self, Gosu::default_font_name, 20)
      @fonts['game_over'] = Gosu::Font.new(self, Gosu::default_font_name, 50)
      @fonts['hint'] = Gosu::Font.new(self, Gosu::default_font_name, 15)
      @fonts['debug'] = Gosu::Font.new(self, Gosu::default_font_name, 15)
    end

    def start_game
      self.mouse_x = WIDTH / 2
      self.mouse_y = HEIGHT / 2
      @player = Player.new(WIDTH / 2, HEIGHT / 2)
      @level = 1
      @turn = 0
      @game_over = false
      @enemies = create_enemies
      @state = :play
    end
    
    def update
      case @state
      when :play
        @player.score += @level + @enemies.size * @level
        update_enemies
        update_player_position
        detect_collisions
      when :game_over
        update_player_position
      end
    end

    def draw
      case @state
      when :play then draw_play
      when :game_over then draw_game_over
      end
      draw_debug
    end
    
    def draw_play
      draw_background
      draw_player
      draw_enemies
      draw_score
    end

    def draw_game_over
      draw_background
      draw_player
      draw_enemies
      draw_score
      draw_game_over_titles
    end

    def draw_background
      draw_quad(0, 0, TOP_COLOR, WIDTH, 0, TOP_COLOR, 0, HEIGHT, BOTTOM_COLOR, WIDTH, HEIGHT, BOTTOM_COLOR, 0)
    end

    def draw_player
      draw_quad(*@player.to_draw, 0)
    end

    def draw_enemies
      @enemies.each do |enemy|
        draw_quad(*enemy.to_draw, 0)
      end
    end

    def draw_game_over_titles
      @fonts['game_over'].draw("GAME OVER", 200, 200, 0)
      @fonts['hint'].draw("press R to restart", 250, 236, 0)
    end

    def update_enemies
      update_enemies_position
      update_enemies_existance
    end

    def update_player_position
      @player.x = self.mouse_x
      @player.y = self.mouse_y
    end

    def update_enemies_position
      @enemies.each do |enemy|
        enemy.tick
      end
    end

    def update_enemies_existance
      @enemies = @enemies.select do |enemy| 
        enemy.left > 0 and enemy.right < WIDTH and enemy.top > 0 and enemy.bottom < HEIGHT
      end

      if @enemies.empty?
        @turn += 1
        @enemies = create_enemies
      end
    end

    def draw_score
      @fonts['score'].draw("score: #{@player.score}", 5, 5, 0)
    end

    def draw_debug
      @fonts['debug'].draw("X: #{@player.x}", 5, 450, 0)
      @fonts['debug'].draw("Y: #{@player.y}", 5, 460, 0)
      @fonts['debug'].draw("enemies: #{@enemies.size}", 65, 450, 0)
      @fonts['debug'].draw("state: #{@state.to_s}", 65, 460, 0)    
    end

    def detect_collisions
      @enemies.each do |enemy|
        if check_collision(@player, enemy)
          @state = :game_over
        end
      end
    end

    def check_collision(a, b)
      ! (b.left > a.right or b.right < a.left or b.top > a.bottom or b.bottom < a.top)
    end

    def button_down(key)
      if key == Gosu::KbR
        restart_game
      end
      if key == Gosu::KbEscape
        close
      end
    end

    def restart_game
      start_game
    end

  end

end