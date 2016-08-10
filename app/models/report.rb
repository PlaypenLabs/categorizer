class Report < ActiveRecord::Base
  belongs_to :action_message, foreign_key: :action_id, counter_cache: true
  belongs_to :category, counter_cache: true
  belongs_to :user
  belongs_to :ticket

  validates :category_id, presence: true

  scope :with_categories, -> { where.not(category_id: nil) }
  scope :with_actions, -> { where.not(action_id: nil) }


  def self.retrieve_grouped_categories
    Report.includes(:category).with_categories.group_by(&:category)
  end

  def self.retrieve_grouped_actions
    Report.includes(:action_message, :category).with_actions.group_by(&:action_message)
  end
end
