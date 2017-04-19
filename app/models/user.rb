class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :categories
  has_many :action_messages
  has_many :reports

  belongs_to :organization

  validates :zendesk_email, :zendesk_password, presence: true
  validates :organization_id, presence: { message: ' sub domain can not be blank' }

  after_create :add_defaults

  def first_login?
    self.sign_in_count <= 1
  end

  def add_defaults
    Category::DEFAULT_CATEGORIES.each{ |category| self.categories.create(name: category) }
    ActionMessage::DEFAULT_ACTIONS.each{ |action_message| self.action_messages.create(name: action_message) }
  end

  def set_email_reports
    self.reports.update_all(is_emailed: true)
  end

  def first_week?
    self.created_at >= 1.week.ago
  end
end
