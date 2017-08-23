require './products'

class Report

  def initialize(products)
    @products = products
  end

  def run(red_only: false)
    selection = select_products(red_only)

    money_taken = selection.reduce(0) do |total, product|
      (product.price * product.sales) + total
    end

    total_sales = selection.reduce(0) do |total, product|
      product.sales + total
    end

    {
      average_sales_price: money_taken / total_sales,
      money_taken: money_taken
    }
  end

  def top_selling(red_only)
    select_products(red_only).sort_by(&:sales).last(3)
  end

  def select_products(red_only)
    selection = @products

    if red_only
      selection = selection.select { |product| product.color == :red }
    end

    selection
  end

end

p Report.new(product_list).run
p Report.new(product_list).run(red_only:true)
