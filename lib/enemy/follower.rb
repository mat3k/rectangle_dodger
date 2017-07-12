module RectangleDodger
  module Enemy
    class Follower < Base
      def initialize(height, speed=2, player)
        super(1, rand(height), 30, 30, Gosu::Color.new(0xFFFFDE5C))
        @x_speed = 12
        @player = player
        @y_speed = 2
      end

      def tick
        @x += @x_speed
        if @x < @player.x
          if @y < @player.y
            @y += @y_speed
          elsif @y > @player.y
            @y -= @y_speed
          end
        end
      end
    end
  end
end
