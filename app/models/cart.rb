class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def item_count
    @contents.values.sum
  end

  # def add_item(id)
  #   @contents[id.to_s] = @contents[id.to_s] + 1
  # end
end
