class Window < Gosu::Window
  def initialize(name)
    super(*Processor::Screen)
    self.caption = "Blast Mavens: Multiplayer Beta v0.1.0"
    set_delegate(name)
  end

  def draw
    @delegate.draw
  end

  def update
    @delegate.update
  end

  def button_down(id)
    @delegate.button_down(id)
  end

  def set_delegate(name, opts={})
    @delegate = Object.const_get(name).new(self, opts)
  end

  def method_missing(sym, *args, &block)
    @delegate.send(sym, *args, &block)
  end
end