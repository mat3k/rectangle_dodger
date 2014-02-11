module RectangleDodger

  class Rectangle
    HEIGHT = 10
    WIDTH = 10
    X = 0
    Y = 0
    COLOR = Gosu::Color.new(0xFFFFFFFF)

    attr_accessor :x, :y, :width, :height

    def initialize(x=X, y=Y, width=WIDTH, height=HEIGHT, color=COLOR)
      @x = x
      @y = y
      @width = width
      @height = height
      @color = color
    end

    def left
      @x
    end

    def right
      @x + WIDTH
    end

    def top
      @y
    end

    def bottom
      @y + HEIGHT
    end

    def to_draw
      [left, top, @color, right, top, @color, left, bottom, @color, right, bottom, @color]
    end

  end

end