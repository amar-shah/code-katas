module ItemsCounter
  def count_promoted_items_size(items)
    grouped_items = items.group_by { |i| i.code }

    if pitems = grouped_items[item_code]
      pitems.size
    else
      0
    end
  end
end
