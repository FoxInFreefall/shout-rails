class Project < ActiveRecord::Base
  # Association macros
  has_many :collaborations, dependent: :destroy
  has_many :members, through: :collaborations, :source => :user

  has_many :invitations, dependent: :destroy
  has_many :potential_members, through: :invitations, :source => :user

  # Validation macros
  validates :name, presence: true
end
