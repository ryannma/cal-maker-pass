class CartItem
  attr_accessible :quantity, :item

  def new( item, quantity )
  	@item = item
  	@quantity = quantity
  end

  def price
  	@item.price
  end

  def name
  	@item.name
  end

  def item_id
  	@item.id
  end
end