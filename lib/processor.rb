require 'window'

class Processor
  class << self
    def new
      @window = Window.new
      @window.show
    end
  end
end