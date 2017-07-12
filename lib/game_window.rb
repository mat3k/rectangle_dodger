module RectangleDodger
  class GameWindow < Gosu::Window
    include RectangleDodger

    TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
    BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

    WIDTH = 640
    HEIGHT = 480

    PLAYER_WIDTH = 10
    PLAYER_HEIGHT = 10

    attr_reader :game

    def initialize
      super(WIDTH, HEIGHT, false)
      self.caption = "Rectangle Dodger"
      init_fonts
      @game = Game.new(WIDTH / 2, HEIGHT / 2)
    end

    def init_fonts
      @fonts = {
        score: Gosu::Font.new(self, Gosu::default_font_name, 20),
        game_over: Gosu::Font.new(self, Gosu::default_font_name, 50),
        hint: Gosu::Font.new(self, Gosu::default_font_name, 15),
        debug: Gosu::Font.new(self, Gosu::default_font_name, 15)
      }
    end

    def update
      case game.state
      when :play
        game.update_score
        game.update_enemies
        game.update_player(self.mouse_x, self.mouse_y)
        game.detect_collisions
      when :game_over
        game.update_player(self.mouse_x, self.mouse_y)
      end
    end

    def draw
      case game.state
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
      draw_quad(*game.player.to_draw, 0)
    end

    def draw_enemies
      game.enemies.each do |enemy|
        draw_quad(*enemy.to_draw, 0)
      end
    end

    def draw_game_over_titles
      @fonts[:game_over].draw("GAME OVER", 200, 200, 0)
      @fonts[:hint].draw("press R to restart", 250, 236, 0)
    end

    def draw_score
      @fonts[:score].draw("score: #{game.score}", 5, 5, 0)
    end

    def draw_debug
      @fonts[:debug].draw("LVL: #{game.level}", 5, 430, 0)
      @fonts[:debug].draw("FPS: #{Gosu.fps}", 5, 440, 0)
      @fonts[:debug].draw("X: #{game.player.x}", 5, 450, 0)
      @fonts[:debug].draw("Y: #{game.player.y}", 5, 460, 0)
      @fonts[:debug].draw("enemies: #{game.enemies.size}", 65, 450, 0)
      @fonts[:debug].draw("state: #{game.state.to_s}", 65, 460, 0)
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
      @game = Game.new(WIDTH / 2, HEIGHT / 2)
    end
  end
end
