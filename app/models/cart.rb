class Cart
  attr_reader :contents

  def initialize(contents)
    if !contents.nil?
      @contents = contents
      @contents.default = 0
    else
      @contents = Hash.new(0)
    end
  end

  def item_count
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end
end
