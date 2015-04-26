class Cart
  attr_accessor :user, :cart_items, :comment

  def initialize
    @user = nil
    @cart_items = []
    @comment = ""
    self
  end

  def empty?
    @cart_items == []
  end

  def each &block
    puts @cart_items, 'each'
    @cart_items.each(&block)
  end

  def add_item( id )
  	clean_cart
  	if id.empty? then return end
    id = id.to_i
    curr_cart_item = @cart_items.detect { |cart_item|
      cart_item.item_id == id
    }
    unless curr_cart_item.nil?
      curr_cart_item.quantity += 1
    else
      item = Item.find(id)
      curr_cart_item = CartItem.new(item, 1)
      @cart_items << curr_cart_item
    end
  end

  def delete_item( id )
    if id.empty? then return end
    id = id.to_i
    @cart_items.delete_if { |cart_item|
      cart_item.item_id == id
    }
  end

  def clean_cart
  	new_cart = []
  	@cart_items.each do |cart_item|
  		begin
  			item = Item.find(cart_item.item_id)
  			new_cart << cart_item
  		rescue

  		end
  	end
  	@cart_items = new_cart
  end

  def clear
    @user = nil
    @cart_items = nil
    @comment = nil
  end

  def total
    sum = 0
    @cart_items.each{ |cart_item| 
      sum += ( cart_item.price * cart_item.quantity )
    }
  end
end
