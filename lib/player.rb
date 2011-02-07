class Player
  def initialize
    @t_size      = Processor::TileSize
    @sprites     = Gosu::Image.load_tiles(Processor.window, "resources/images/temp_char.png", @t_size, @t_size, false)
    @index       = Processor.has_at_least_one_player? ? 1 : 0
    @movement    = {[Gosu::Button::KbLeft,  Gosu::Button::KbA] => [[-1, 0],[0, 0, 0, 43]],
                    [Gosu::Button::KbRight, Gosu::Button::KbD] => [[1, 0], [43, 0, 43, 43]],
                    [Gosu::Button::KbUp,    Gosu::Button::KbW] => [[0, -1],[43, 0, 0, 0]],
                    [Gosu::Button::KbDown,  Gosu::Button::KbS] => [[0, 1],[43, 43, 0, 43 ]]}
    start_coords = [@t_size * 1 + 1, @t_size * 14 + 1]
    @x = @y = start_coords[@index]
  end

  def draw
    @sprites.first.draw(@x, @y, 1)
  end

  def update
    keyboard_control = @movement.detect {|keys, movement| Processor.window.button_down?(keys[@index]) }
    if keyboard_control
      move_instruct = keyboard_control.last
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

  def no_collision?(target)
    !Processor.window.map.solid_at?(@x+target[0]+target[2], @y+target[1]+target[3])
  end

end