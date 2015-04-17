class CartItem
  attr_accessor :quantity, :item

  def initialize(item, quantity)
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

  def to_s
    "quantity: #{@quantity}, item: #{@item.name}"
  end
end