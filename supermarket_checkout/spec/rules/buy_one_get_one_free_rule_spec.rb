require File.expand_path('../../spec_helper', __FILE__)

describe BuyOneGetOneFreeRule do
  let(:promoted_item) { double('promoted_item', :code => 'PR1', :price => 4.0) }
  let(:other_item) { double('item', :code => 'PC1', :price => 3.0) }

  subject{ BuyOneGetOneFreeRule.new(promoted_item.code, promoted_item.price)}

  describe '#discount' do
    context 'when discount is applicable' do
      context 'and there are 2 promoted items' do
        let(:items) do
          [promoted_item, other_item, promoted_item]
        end

        it 'returns discount amount == price' do
          subject.discount(items).should == promoted_item.price
        end
      end

      context 'and there are 3 promoted items' do
        let(:items) do
          [promoted_item, promoted_item, other_item, promoted_item]
        end

        it 'returns discount amount == price' do
          subject.discount(items).should == promoted_item.price
        end
      end

      context 'and there are 4 promoted items' do
        let(:items) do
          [promoted_item, promoted_item, promoted_item, other_item, promoted_item]
        end

        it 'returns discount amount == 2*price' do
          subject.discount(items).should == 2 * promoted_item.price
        end
      end

    end

    context 'when discount is not applicable' do
      let(:items) { [promoted_item, other_item] }
      it 'returns discount amount eql 0' do
        subject.discount(items).should == 0.0
      end
    end
  end
end
