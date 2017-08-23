require './products'

by_attribute = -> attr, op, value, products do
  products.select { |p| p[attr].send(op, value) }
end

by_color = by_attribute.curry[:color, :==]
blue = by_color.curry[:blue]

blue[PRODUCTS].take(3)

by_max_rating = by_attribute.curry[:rating, :<]
low_rating = by_max_rating.curry[3]

class FunctionalReport
  def initialize(products, *funcs)
    @products = products
    @funcs = funcs
  end

  def run
    @funcs.reduce(@products) do |last_result, fn|
      fn[last_result]
    end
  end
end

p FunctionalReport.new(PRODUCTS, blue, low_rating).run.take(3)
