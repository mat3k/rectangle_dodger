module RectangleDodger
  module Enemy
    class Sinusoid < Base
      def initialize(height, speed=2)
        super(1, rand(height), 30, 30, Enemy::COLOR)
        @x_speed = speed
        @y_speed = 0.1
        @sin_v = rand(Math::PI)
        @base_y = rand(height)
        @amplitude = rand(50) + 5
      end

      def tick
        super
        move_vertically
      end

      def move_vertically
        @sin_v += @y_speed
        @y = @base_y + Math.sin(@sin_v) * @amplitude
      end
    end
  end
end
