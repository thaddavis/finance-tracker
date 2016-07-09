class Stock < ApplicationRecord

  def self.new_from_lookup(ticker)
    looked_up_stock = StockQuote::Stock.quote(ticker)
    #debugger
    return nil unless looked_up_stock.name

    new_stock = new( ticker: looked_up_stock.symbol, name: looked_up_stock.name, price: looked_up_stock.open )
    #last_price: looked_up_stock.previous_close

    new_stock[:last_price] = new_stock[:price]
    new_stock
  end

  def self.find_by_ticker(ticker)
    where(ticker: ticker).first
  end

  def price

    looked_up_stock = StockQuote::Stock.quote(self[:ticker])

    opening_price = looked_up_stock.open

    return "#{opening_price} (opening price)" if (opening_price)

    previous_closing_price = looked_up_stock.previous_close

    return "#{previous_closing_price} (previous closing price)" if (previous_closing_price)

    'Unavailable'

  end

end
