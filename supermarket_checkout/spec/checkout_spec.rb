require File.expand_path('../spec_helper', __FILE__)

describe Checkout do
  let(:fruit_tea) { stub('item', :code => 'FR1', :price => 3.11) }
  let(:strawberries) { stub('item', :code => 'SR1', :price => 5.0) }
  let(:coffee) { stub('item', :code => 'CF1', :price => 11.23) }

  let(:buy_one_get_one_free_rule) do
    BuyOneGetOneFreeRule.new(fruit_tea.code,fruit_tea.price)
  end

  let(:lower_price_rule) do
    LowerPriceRule.new(strawberries.code, strawberries.price, 4.5)
  end

  let(:rules) { [buy_one_get_one_free_rule, lower_price_rule] }

  subject { Checkout.new(rules) }

  describe '#scan' do
    it 'adds item to basket' do
      subject.scan(fruit_tea).should == true
      subject.instance_variable_get('@basket_items').size == 1
      subject.instance_variable_get('@basket_items')[0] == fruit_tea
    end
  end

  describe '#total' do
    context 'where there are in basket: FR1, SR1, FR1, CF1' do

      before do
        subject.scan(fruit_tea)
        subject.scan(strawberries)
        subject.scan(fruit_tea)
        subject.scan(coffee)
      end

      its(:total) { should == 19.34 }
    end

    context 'where there are in basket: FR1, FR1' do
      before do
        subject.scan(fruit_tea)
        subject.scan(fruit_tea)
      end

      its(:total) { should == 3.11 }
    end

    context 'where there are in basket: SR1, SR1, FR1, SR1' do
      before do
        subject.scan(strawberries)
        subject.scan(strawberries)
        subject.scan(fruit_tea)
        subject.scan(strawberries)
      end

      its(:total) { should == 16.61 }
    end
  end
end
