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

  def first_login?
    self.sign_in_count <= 1
  end
end
