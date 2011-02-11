module Tileable
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def register!(x,y)
      center_x = Processor.center_map.detect{|center, coords| coords.include?(x)}
      center_y = Processor.center_map.detect{|center, coords| coords.include?(y)}
      puts "#{x} #{y}" if center_x.nil? || center_y.nil?
      raise "hell" if center_x.nil? || center_y.nil?
      @center_x, @center_y = center_x.first, center_y.first
      @top  = [@center_x - 24, @center_y - 24]
    end

    def at?(x,y)
      target_center_x = Processor.center_map.detect{|center, coords| coords.include?(x)}
      target_center_y = Processor.center_map.detect{|center, coords| coords.include?(y)}
      puts "#{x} #{y}" if target_center_x.nil? || target_center_y.nil?
      raise "hell #{x} #{y}" if target_center_x.nil? || target_center_y.nil?
      @center_x == target_center_x && @center_y == target_center_y
    end

    def top_x
      @top.first
    end

    def top_y
      @top.last
    end
  end
end