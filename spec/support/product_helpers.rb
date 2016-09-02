module ProductHelpers
  def lookup_asin_on_amazon(asin)
    Amazon::EcsWrapper.get_item_group(asin)
  end
  def return_items(asin)
    res = lookup_asin_on_amazon(asin)
    return res if !res.respond_to?('error')
  end
  def res_text(asin)
    res = lookup_asin_on_amazon(asin)
    if res.respond_to?('error')
      return res.error
    else
      return res.length.to_s + " item(s) are found."
    end
  end
end
