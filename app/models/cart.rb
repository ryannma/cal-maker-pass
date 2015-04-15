class Cart
  attr_accessible :user, :items, :comment

  def add_item( id )

  	item = @items.detect { |cart_item|
  		cart_item.item_id == id
  	}

  	unless item.nil?
  		item.quantity += 1
  	} else {
  		item = Item.find( id )
  		curr_item = CartItem.new( item, 1 )
  		@items << curr_item
  	}

  end

  def clear
    @user = nil
    @items = nil
    @comment = nil
  end

  def total
  	@items.inject { |total, cart_item|
		total + ( cart_item.price * cart_item.quantity )
  	}
  end


end
