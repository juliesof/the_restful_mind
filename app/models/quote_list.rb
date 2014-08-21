class Quote_List < ActiveRecord::Base
  references :user
  has_many :quotes

end
