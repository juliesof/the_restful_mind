class User < ActiveRecord::Base
  has_many :sittings
  has_one :quote_list

end
