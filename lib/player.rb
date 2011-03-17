class Player

  attr_reader :bombs, :explosions, :x, :y
  def initialize
    @t_size       = Processor::TileSize
    @sprites      = Gosu::Image.load_tiles(Processor.game_window, "resources/images/char_3.png", @t_size, @t_size, false)
    @index        = Processor.has_at_least_one_player? ? 1 : 0
    @bombs        = []
    @explosions   = []
    @move_control = {[Gosu::Button::KbA,       Gosu::Button::KbLeft] => [[-1, 0],[0, 0, 0, 40]],
                    [Gosu::Button::KbD,        Gosu::Button::KbRight] => [[1, 0], [40, 0, 40, 40]],
                    [Gosu::Button::KbW,        Gosu::Button::KbUp   ] => [[0, -1],[40, 0, 0, 0]],
                    [Gosu::Button::KbS,        Gosu::Button::KbDown ] => [[0, 1],[40, 40, 0, 40 ]]}
    @bomb_control = [Gosu::Button::KbSpace,    Gosu::Button::KbRightAlt]
    start_coords = [@t_size * 1 + 1, @t_size * 14 + 1]
    @x = @y = start_coords[@index]

    if @index == 1
      # @brain = BasicBrain.new(self, Processor.players[0])
    end
  end

  def draw
    @sprites.first.draw(@x, @y, 2)
  end

  def update
    movement!
    bombs!
  end

  def no_collision?(target)
    target_x = @x+target[0]+target[2]
    target_y = @y+target[1]+target[3]
    !solid_at?(target_x, target_y) && !Processor.all_bombs.detect{|bomb| bomb.solid_at?(target_x, target_y)}
  end

private
  def movement!
    move_instruct = @brain ? @brain.move_instructions : input_move_instructions
    if move_instruct
      x_y = move_instruct.first
      inc_x, inc_y = x_y
      tar_x1, tar_y1, tar_x2, tar_y2 = *move_instruct.last
      4.times do |i|#speed
        if no_collision?(x_y + [tar_x1, tar_y1]) && no_collision?(x_y + [tar_x2, tar_y2])
          update_bomb_solidness
          @x += inc_x
          @y += inc_y

        end
      end
    end
  end

  def bombs!
    if Processor.game_window.button_down?(@bomb_control[@index]) && !@bombs.detect {|bomb| bomb.at?(center_x, center_y)}
      @bombs << Bomb.new(center_x, center_y) if Processor.game_window.button_down?(@bomb_control[@index])
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
    Processor.game_window.map.solid_at?(x, y)
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

  def update_bomb_solidness
    bombs.each do |bomb|
      bomb.solid = true unless bomb.solid || bomb.at?(center_x, center_y)
    end
  end

  def input_move_instructions
    move = @move_control.detect {|keys, movement| Processor.game_window.button_down?(keys[@index]) }
    move.last if move
  end
end