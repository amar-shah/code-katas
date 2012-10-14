class Cell
  attr_writer :number_of_live_neighbors
  def initialize(state=false)
    @state = !!state
  end

  def live?
    @state
  end

  def change_state!
    @state = (next_state == :live)
  end

  def next_state
    return :dead if not live? and @number_of_live_neighbors != 3
    return :dead if live? and (@number_of_live_neighbors < 2 or @number_of_live_neighbors > 3)
    :live
  end

  def to_s
    live? ? 'X' : ' '
  end
end
