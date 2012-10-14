require_relative '../lib/cell'

describe Cell do

  let(:cell) { Cell.new }

  describe "next_state" do
    before do
      cell.number_of_live_neighbors = number_of_live_neighbors
    end

    context "when cell is live" do
      let(:cell) { Cell.new(true) }

      context "and there are 2 live neighbors" do
        let(:number_of_live_neighbors) { 2 }

        it 'should be live' do
          cell.next_state.should == :live
        end
      end

      context "and there are 3 live neighbors" do
        let(:number_of_live_neighbors) { 3 }

        it 'should be live' do
          cell.next_state.should == :live
        end
      end

      [0,1,4,5,6,7,8].each do |number|
        context "and there are #{number} live neighbors" do
          let(:number_of_live_neighbors) { number }

          it 'should be dead' do
            cell.next_state.should == :dead
          end
        end
      end
    end

    context 'when cell is dead' do
      let(:number_of_live_neighbors) { 3 }
      let(:cell) { Cell.new(false) }

      context 'and has excatly 3 neighbors' do
        it 'should be live' do
          cell.next_state.should == :live
        end
      end

      [0,1,2,4,5,6,7,8].each do |number|
        context "and there are #{number} live neighbors" do
          let(:number_of_live_neighbors) { number }

          it 'should be dead' do
            cell.next_state.should == :dead
          end
        end
      end
    end
  end

  describe '#change_state!' do
    let(:cell) { Cell.new(false) }

    context 'when next_state is :live' do
      before do
        cell.stub(:next_state){ :live }
      end

      it 'changes state to live' do
        cell.change_state!
        cell.live?.should be_true
      end
    end

    context 'when next_state is :dead' do
      before do
        cell.stub(:next_state){ :dead }
      end

      it 'changes state to live' do
        cell.change_state!
        cell.live?.should be_false
      end
    end
  end

  describe '#live?' do
    context 'when state flag is true' do
      before { cell.instance_variable_set(:@state, true) }

      it { cell.live?.should be_true }
    end

    context 'when live flag is false' do
      before { cell.instance_variable_set(:@state, false) }

      it { cell.live?.should be_false }
    end
  end
end
