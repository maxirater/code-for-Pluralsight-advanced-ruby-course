require './products'

red = -> products { products.select { |p| p.color == :red } }

class ColorFilter
  def initialize(color)
    @color = color
  end

  def apply(products)
    products.select { |p| p.color == @color }
  end
end

filter = ColorFilter.new(:blue)
p filter.apply(PRODUCTS).take(3)
