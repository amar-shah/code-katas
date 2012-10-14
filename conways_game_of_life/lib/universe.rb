class Universe

  def self.negihbours_coordinates(coordinates)
    x, y = coordinates
    [
      [x  , y-1], [x  , y+1],
      [x-1, y  ], [x+1, y  ],
      [x-1, y-1], [x+1, y+1],
      [x-1, y+1], [x+1, y-1]
    ]
  end

  def initialize(width, height, initial_live_celss = nil)
    @width, @height = width, height
    @initial_live_celss = initial_live_celss
  end

  def at(x,y)
    world[x][y]
  rescue NoMethodError => e
    nil
  end

  def next_generation!
    @width.times do |x|
      @height.times do |y|
        at(x, y).number_of_live_neighbors = number_of_live_negihbors_for(x, y)
      end
    end

    @width.times do |x|
      @height.times do |y|
        at(x, y).change_state!
      end
    end
  end

  def number_of_live_negihbors_for(x,y)
    live_cells = 0
    Universe.negihbours_coordinates([x,y]).each do |coordinates|
      live_cells += 1 if cell = at(*coordinates) and cell.live?
    end
    live_cells
  end

  private
  def world
    setup_world unless @world
    @world
  end

  def setup_world
    @world = Array.new(@width)
    @width.times do |x|
      @world[x] = Array.new(@height)
      @height.times do |y|
        flag = (@initial_live_celss and @initial_live_celss.include?([x,y]))
        @world[x][y] = Cell.new(flag)
      end
    end
  end
end
