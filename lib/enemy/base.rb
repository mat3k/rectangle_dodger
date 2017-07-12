module RectangleDodger
  module Enemy
    COLOR = Gosu::Color.new(0xFFFFDE5C)

    class Base < RectangleDodger::Rectangle
      def tick
        move_horizontally
      end

      def move_horizontally
        @x += @x_speed
      end
    end
  end
end
