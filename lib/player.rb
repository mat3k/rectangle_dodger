class Player < Rectangle
  attr_accessor :score

  def initialize(x, y)
    super(x, y, 10, 10)
    @score = 0
  end


end