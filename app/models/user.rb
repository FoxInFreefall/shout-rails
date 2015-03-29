class User < ActiveRecord::Base
  # Association macros
  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations

  has_many :invitations, dependent: :destroy
  has_many :potential_projects, through: :invitations, :source => :project

  # Callbacks
  before_save :ensure_authentication_token

  # Devise macros
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
