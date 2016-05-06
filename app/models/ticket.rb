class Ticket < ActiveRecord::Base
  has_one :report
end
