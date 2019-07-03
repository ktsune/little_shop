class Cart
  attr_reader :contents

  def initialize(contents)
    if contents
      @contents = contents
    else
      @contents = Hash.new(0)
    end
  end

  def item_count
    @contents.values.sum
  end

  def add_item(id)
    @contents[id] += 1
  end
end
