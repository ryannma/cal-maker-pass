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
    curr_cart_item = @cart_items.detect { |cart_item|
      cart_item.item_id == id.to_i
    }

    unless curr_cart_item.nil?
      curr_cart_item.quantity += 1
    else
      item = Item.find( id )
      curr_cart_item = CartItem.new( item, 1 )
      @cart_items << curr_cart_item
    end

  end

  def clear
    @user = nil
    @cart_items = nil
    @comment = nil
  end

  def total
    sum = 0
    @cart_items.each{|cart_item| 
      sum += ( cart_item.price * cart_item.quantity )
    }
  end


end