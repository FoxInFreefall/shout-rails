class Project < ActiveRecord::Base
  # Association macros
  has_many :collaborations
  has_many :users, through: :collaborations

  has_many :invitations
  has_many :invites, through: :invitations, :source => :user

  # Validation macros
  validates :name, presence: true
end
