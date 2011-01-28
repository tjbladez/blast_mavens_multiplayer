class Window < Gosu::Window
  def initialize
    super(1024, 768, false)
    self.caption = "Bomber"
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end