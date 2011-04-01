class MenuWindow < Gosu::Window
  def initialize
    super(*Processor::Screen)
    @pointer    = Gosu::Image.new(self,"resources/images/cursor.png",true)
    @background = Gosu::Image.load_tiles(self, 'resources/images/menu3.png', 1024, 768, true).first
    @new_game   = Gosu::Image.load_tiles(self, 'resources/images/newgame.png', 80, 20, true).first
    @options    = Gosu::Image.load_tiles(self, 'resources/images/options.png', 80, 20, true).first
    @exit_game  = Gosu::Image.load_tiles(self, 'resources/images/exitgame.png', 80, 20, true).first
    @px = @py = 0
  end

  def update
    @px, @py = mouse_x, mouse_y
  end

  def draw
    @background.draw(0,0,0)
    @new_game.draw(470, 320, 1)
    @options.draw(470, 350, 1)
    @exit_game.draw(470, 380, 1)
    @pointer.draw(@px,@py,2)
  end

  def mouse_clicked(x, y)
    if (380..480).include?(x) && (280..320).include?(y)
      close
      Processor.start_game
    end
    close if (380..480).include?(x) && (380..420).include?(y)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    Processor.start_game if id == Gosu::KbReturn
    mouse_clicked(@px, @py) if id == Gosu::MsLeft
  end
end