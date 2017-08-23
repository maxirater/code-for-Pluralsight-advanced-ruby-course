require './products'

sum = -> list { list.reduce(&:+) }

sales_value = -> products do
  product_revenue = products.map { |product| product.sales * product.price }
  sum[product_revenue]
end

total_sales = -> products { sum[products.map(&:sales)] }

avg_sale_price = -> products { sales_value[products] / total_sales[products] }

avg_sale_price[PRODUCTS] # => 44 (actually 66)

red = -> products { products.select { |p| p.color == :red } }

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


puts FunctionalReport.new(PRODUCTS, avg_sale_price).run
puts FunctionalReport.new(PRODUCTS, red, avg_sale_price).run

green = -> products { products.select { |p| p.color == :green } }
high_rating = -> products { products.select { |p| p.rating >= 3 } }

puts FunctionalReport.new(PRODUCTS, green, high_rating, total_sales).run
