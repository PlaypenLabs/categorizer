class ActionMessage < ActiveRecord::Base
  belongs_to :user
  has_many :reports, foreign_key: :action_id
  has_many :tickets

  validates :name, presence: true
end
