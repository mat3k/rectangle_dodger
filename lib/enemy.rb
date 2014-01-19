class Enemy < Rectangle
end

class LeftToRight < Enemy

  def initialize(height, speed=2)
    super(1, rand(height), 30, 30, Gosu::Color.new(0xFFFFDE5C))
    @speed = speed
  end

  def tick
    @x += @speed
  end

end

class LeftToRightSinus < Enemy

  def initialize(height, speed=2)
    super(1, rand(height), 30, 30, Gosu::Color.new(0xFFFFDE5C))
    @x_speed = speed
    @y_speed = 0.1
    @sin_v = rand(Math::PI)
    @base_y = rand(height)
    @amplitude = rand(50) + 5
  end

  def tick
    @x += @x_speed
    @sin_v += @y_speed
    @y = @base_y + Math.sin(@sin_v) * @amplitude
  end

end

class LeftToRightFollower < Enemy

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
