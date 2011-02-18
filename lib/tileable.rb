module Tileable
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def register!(x,y)
      @center_x, @center_y = *Processor.center_for(x, y)
      @top     = [@center_x - 24, @center_y - 24]
    end

    def at?(x,y)
      center == Processor.center_for(x, y)
    end

    def center
      [@center_x, @center_y]
    end

    def top_x
      @top.first
    end

    def top_y
      @top.last
    end
  end
end