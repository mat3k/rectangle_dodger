module RectangleDodger
  module Enemy
    class Straight < Base
      def initialize(height, speed=2)
        super(1, rand(height), 30, 30, Gosu::Color.new(0xFFFFDE5C))
        @speed = speed
      end

      def tick
        @x += @speed
      end
    end
  end
end
