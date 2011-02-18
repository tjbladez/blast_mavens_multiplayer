class Player

  attr_reader :bombs, :explosions
  def initialize
    @t_size       = Processor::TileSize
    @sprites      = Gosu::Image.load_tiles(Processor.window, "resources/images/temp_char.png", @t_size, @t_size, false)
    @index        = Processor.has_at_least_one_player? ? 1 : 0
    @bombs        = []
    @explosions   = []
    @move_control = {[Gosu::Button::KbLeft,  Gosu::Button::KbA] => [[-1, 0],[0, 0, 0, 43]],
                    [Gosu::Button::KbRight, Gosu::Button::KbD] => [[1, 0], [43, 0, 43, 43]],
                    [Gosu::Button::KbUp,    Gosu::Button::KbW] => [[0, -1],[43, 0, 0, 0]],
                    [Gosu::Button::KbDown,  Gosu::Button::KbS] => [[0, 1],[43, 43, 0, 43 ]]}
    @bomb_control = [Gosu::Button::KbSpace, Gosu::Button::KbRightAlt]
    start_coords = [@t_size * 1 + 1, @t_size * 14 + 1]
    @x = @y = start_coords[@index]
  end

  def draw
    @sprites.first.draw(@x, @y, 2)
  end

  def update
    movement!
    bombs!
  end

  def no_collision?(target)
    !solid_at?(@x+target[0]+target[2], @y+target[1]+target[3])
  end

private
  def movement!
    move_control = @move_control.detect {|keys, movement| Processor.window.button_down?(keys[@index]) }
    if move_control
      move_instruct = move_control.last
      x_y = move_instruct.first
      inc_x, inc_y = x_y
      tar_x1, tar_y1, tar_x2, tar_y2 = *move_instruct.last
      4.times do |i|#speed
        if no_collision?(x_y + [tar_x1, tar_y1]) && no_collision?(x_y + [tar_x2, tar_y2])
          @x += inc_x
          @y += inc_y
        end
      end
    end
  end

  def bombs!
    if Processor.window.button_down?(@bomb_control[@index]) && !@bombs.detect {|bomb| bomb.at?(center_x, center_y)}
      @bombs << Bomb.new(center_x, center_y) if Processor.window.button_down?(@bomb_control[@index])
    end
    check_bomb_existance
    check_explosion_existance
  end

  def check_bomb_existance
    @bombs.reject! do |bomb|
      if bomb.time_counter == 0
        @explosions << Explosion.new(bomb.top_x, bomb.top_y)
        explode_direction(bomb.top_x, bomb.top_y, :right)
        explode_direction(bomb.top_x, bomb.top_y, :left)
        explode_direction(bomb.top_x, bomb.top_y, :up)
        explode_direction(bomb.top_x, bomb.top_y, :down)
        true
      end
    end
  end

  def check_explosion_existance
    @explosions.reject! { |explosion| explosion.time_counter == 0}
  end

  def center_x
    @x + 24
  end

  def center_y
    @y + 24
  end

  def solid_at?(x, y)
    Processor.window.map.solid_at?(x, y)
  end

  def explode_direction(x,y, direction)
    [@t_size, @t_size*2].each do |inc|
      case direction
      when :right then new_x, new_y = x + inc, y
      when :left  then new_x, new_y = x - inc, y
      when :down  then new_x, new_y = x, y + inc
      when :up    then new_x, new_y = x, y - inc
      end

      break if solid_at?(new_x, new_y)
      @explosions << Explosion.new(new_x, new_y)
    end
  end
end