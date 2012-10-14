require_relative '../lib/game'

describe Game do
  let(:game) { Game.new(5,5)}

  describe "#universe" do
    it 'create universe with cells' do
      game.universe.at(4, 4).should be_kind_of Cell
      game.universe.at(0, 0).should be_kind_of Cell
      game.universe.at(5, 5).should be_nil
    end
  end
end
