class MenuWindow < Gosu::Window
  def initialize
    super(*Processor::Screen)
    @pointer = Gosu::Image.new(self,"resources/images/cursor.png",true)
    # @font = Gosu::Font.new(self, Gosu::DefautFont, true, 20)
    @px = @py = 0
  end

  def update
    @px, @py = mouse_x, mouse_y
  end

  def draw
    @pointer.draw(@px,@py,0)
  end

  def mouse_clicked(x, y)
    Processor.start_game
  end

  def button_down(id)
    return Processor.start_game if id == Gosu::KbReturn
    mouse_clicked(@px, @py) if id == Gosu::MsLeft
  end
end