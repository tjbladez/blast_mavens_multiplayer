class BasicBrain
  def initialize(brainholder, enemy)
    @me  = brainholder
    @you = enemy
    @move_control = {:left  => [:left, [-1, 0],[0, 0, 0, 40]],
                     :right => [:right, [1, 0], [40, 0, 40, 40]],
                     :up    => [:up, [0, -1],[40, 0, 0, 0]],
                     :down  => [:down, [0, 1],[40, 40, 0, 40 ]]}
  end

  def move_instructions
    x_diff = @me.x - @you.x
    y_diff = @me.y - @you.y

    return @move_control[:left] if x_diff > 24
    return @move_control[:right] if x_diff < -24
    return @move_control[:up] if y_diff > 24
    return @move_control[:down] if y_diff < -24
    return nil
  end

  def placing_bomb?
    return false
  end
end