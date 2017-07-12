module RectangleDodger
  module Enemy
    class Straight < Base
      def initialize(height, speed=5)
        super(1, rand(height), 30, 30, Enemy::COLOR)
        @x_speed = speed
      end
    end
  end
end
