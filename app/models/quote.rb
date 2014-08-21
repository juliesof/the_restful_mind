class Quote < ActiveRecord::Base
  references :quote_list

end
