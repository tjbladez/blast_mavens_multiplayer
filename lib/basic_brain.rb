class BasicBrain
  def initialize(brainholder, enemy)
    @me  = brainholder
    @you = enemy
    @move_control = {:left  => [[-1, 0],[0, 0, 0, 43]],
                     :right => [[1, 0], [43, 0, 43, 43]],
                     :up    => [[0, -1],[43, 0, 0, 0]],
                     :down  => [[0, 1],[43, 43, 0, 43 ]]}
  end

  def move_instructions
    x_diff = @me.x - @you.x
    y_diff = @me.y - @you.y

    return @move_control[:left] if x_diff > 48
    return @move_control[:right] if x_diff < -48
    return @move_control[:up] if y_diff > 48
    return @move_control[:down] if y_diff < -48
    return nil
  end

  def move(direction)
    @last_move = direction
    return @move_control[direction]
  end

  #todo: figure out a way when to place a bomb
  def placing_bomb?
    false
  end
end