class Window < Gosu::Window
  def initialize
    super(*Processor::Screen)
    self.caption = "Bomber"
    @map = Map.new('resources/maps/basic.txt')
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end