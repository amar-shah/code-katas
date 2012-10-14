class LowerPriceRule
  include ItemsCounter

  attr_reader :item_code
  def initialize(item_code, item_price, new_price)
    @item_code = item_code
    @item_price = item_price
    @new_price = new_price
  end

  def discount(items)
    promoted_items_size = count_promoted_items_size(items)
    return 0 if not applicable?(promoted_items_size)

    promoted_items_size * (@item_price - @new_price)
  end

  def applicable?(promoted_items_size)
    promoted_items_size >= 3
  end
end
