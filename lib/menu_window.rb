class MenuWindow < Gosu::Window
  def initialize
    super(*Processor::Screen)
    @pointer = Gosu::Image.new(self,"resources/images/cursor.png",true)
    @font    = Gosu::Font.new(self, Gosu::default_font_name, 20)

    @px = @py = 0
  end

  def update
    @px, @py = mouse_x, mouse_y
  end

  def draw
    @pointer.draw(@px,@py,0)
    @font.draw('Start Game', 400, 300, 1)
    @font.draw('Options', 400, 350, 1)
    @font.draw('Exit', 400, 400, 1)
  end

  def mouse_clicked(x, y)
    Processor.start_game if (380..480).include?(x) && (280..320).include?(y)
    close if (380..480).include?(x) && (380..420).include?(y)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    Processor.start_game if id == Gosu::KbReturn
    mouse_clicked(@px, @py) if id == Gosu::MsLeft
  end
end