class QuoteList < ActiveRecord::Base
  has_many :users
  has_many :quotes

  def random_quote
    quotes.sample
  end


end
