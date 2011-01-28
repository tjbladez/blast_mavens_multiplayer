require 'window'
require 'map'

# Processor is responsible to keep overall configuration knowledge, state
# transitions and keeping track of windows
class Processor
  Screen = [1024, 768, false]
  class << self
    attr_accessor :window
    def new
      self.window = Window.new
      window.show
    end
  end
end