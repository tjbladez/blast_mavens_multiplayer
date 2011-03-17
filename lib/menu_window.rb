class MenuWindow < Gosu::Window
  def initialize
    super(*Processor::Screen)
  end

  def button_down(id)
    Processor.start_game if id == Gosu::KbReturn
  end
end