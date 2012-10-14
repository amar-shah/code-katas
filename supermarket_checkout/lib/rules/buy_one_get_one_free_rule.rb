class BuyOneGetOneFreeRule
  include ItemsCounter

  attr_reader :item_code
  def initialize(item_code, item_price)
    @item_code = item_code
    @item_price = item_price
  end

  def discount(items)
    promoted_items_size = count_promoted_items_size(items)
    return 0 if not applicable?(promoted_items_size)

    (promoted_items_size / 2) * @item_price
  end

  def applicable?(promoted_items_size)
    promoted_items_size >= 2
  end

end
