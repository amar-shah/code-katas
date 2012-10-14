require File.expand_path('../../spec_helper', __FILE__)

describe LowerPriceRule do
  let(:promoted_item) { stub('promoted_item', :code => 'PR1', :price => 4.0) }
  let(:new_price) { 3.5 }
  let(:other_item) { stub('item', :code => 'PC1', :price => 3.0) }

  subject{ LowerPriceRule.new(promoted_item.code, promoted_item.price, new_price)}

  describe '#discount' do
    context 'when applicable?' do
      it 'returns 1.5' do
        items = [promoted_item, promoted_item, other_item, promoted_item]
        subject.discount(items).should == 1.5
      end

      it 'returns 2' do
        items = [promoted_item, promoted_item, promoted_item, other_item, promoted_item]
        subject.discount(items).should == 2.0
      end

    end

    context 'when not applicable?' do
      it 'returns 0' do
        items = [promoted_item, other_item, promoted_item]
        subject.discount(items).should == 0
      end
    end
  end
end
