require_relative './cell'
require_relative './universe'

class Game
  attr_reader :width, :height

  def initialize(width, height)
    @width, @height = width, height
  end

  def universe
    @universe ||= Universe.new(width, height, random_live_cells)
  end

  def run
    loop do
      draw_universe
      sleep(1/6)
      universe.next_generation!
    end
  end

  def random_live_cells
    r = []
    100.times { r << [rand(width), rand(height)] }
    r
  end

  def draw_universe
    system('clear')
    width.times do |x|
      height.times do |y|
        print universe.at(x, y)
      end
      print "\n"
    end
  end
end

if __FILE__ == $0
  Game.new(130, 40).run
end
