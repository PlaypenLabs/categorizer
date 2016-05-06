class Report < ActiveRecord::Base
  belongs_to :action_message, foreign_key: :action_id, counter_cache: true
  belongs_to :category, counter_cache: true
  belongs_to :user
  belongs_to :ticket
end
