class Cart
  attr_reader :contents

  def initialize(contents)
    if !contents.nil?
      @contents = contents
    else
      # @contents = Hash.new(0)
      @contents = {}
    end
    @contents.default = 0

  end

  def item_count
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

  def remove_item(item_id)
    @contents[item_id.to_s] -= 1
  end

  def count_item(item_id)
    @contents[item_id.to_s]
  end

  def total
    @contents.sum do |item_id, quantity|
      item = Item.find(item_id)
      item.price * quantity
    end
  end

  def quantity
    @contents.each do |item_id, quantity|
      quantity
    end
  end

  def display_cart
    cart = @contents.map do |item_id, quantity|
      [Item.find(item_id), quantity]
    end
  end

end
