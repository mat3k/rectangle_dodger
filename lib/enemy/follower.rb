module RectangleDodger
  module Enemy
    class Follower < Base
      def initialize(height, speed=2, player)
        super(1, rand(height), 30, 30, Enemy::COLOR)
        @x_speed = 12
        @player = player
        @y_speed = 2
      end

      def tick
        super
        move_vertically
      end

      def move_vertically
        return nil if @x >= @player.x
        return @y += @y_speed if @y < @player.y
        return @y -= @y_speed if @y > @player.y
      end
    end
  end
end
