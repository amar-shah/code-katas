require_relative '../lib/universe'
require_relative '../lib/cell'

describe Universe do

  def negihbours_coordinates(dimensions)
    Universe.negihbours_coordinates(dimensions)
  end

  def live_cells(the_cell_coord, number_of_live_cells)
    [the_cell_coord] + negihbours_coordinates(the_cell_coord).slice(0, number_of_live_cells)
  end

  describe "#at" do
    let(:live_celss) { [[2,2]] }
    let(:universe){ Universe.new(5, 5, live_celss) }

    context 'when in the scope of the boundaries' do
      it 'returns cell with coordinates x,y' do
        universe.at(2,2).should be_instance_of Cell
      end
    end

    context 'when out of the scope' do
      it 'returns cell with coordinates x,y' do
        universe.at(10,2).should be_nil
      end
    end
  end

  describe "#number_of_live_negihbors_for" do
    let(:live_celss) { [[2,2], [3, 3]] }
    let(:universe){ Universe.new(5, 5, live_celss) }

    it 'returns number of live cells for cell' do
      universe.number_of_live_negihbors_for(2,3).should == 2
    end
  end

  describe "#world" do
    context 'when no initial live cells' do
      let(:universe) { Universe.new(5,5) }

      it 'has only dead cells' do
        (0..4).each do |x|
          (0..4).each do |y|
            universe.at(x,y).live?.should be_false
          end
        end
      end
    end

    context 'when initial live cells are set' do
      let(:live_celss) { [[2,2], [3, 3]] }
      let(:universe){ Universe.new(5,5, live_celss) }

      it 'has live cells on initial positions' do
        universe.at(2, 2).live?.should == true
        universe.at(3, 3).live?.should == true
      end
    end
  end

  describe "#next_generation!" do
    it 'runs the game and change the state of existing cells' do
      live_celss = [[1,2], [2, 2], [3, 2]]
      universe = Universe.new(10,10, live_celss)
      universe.next_generation!

      universe.at(2, 1).live?.should == true
      universe.at(2, 2).live?.should == true
      universe.at(2, 3).live?.should == true
      universe.at(1, 2).live?.should == false
      universe.at(3, 2).live?.should == false
      universe.at(1, 3).live?.should == false
      universe.at(3, 3).live?.should == false
      universe.at(1, 1).live?.should == false
      universe.at(3, 1).live?.should == false
    end
  end
end
