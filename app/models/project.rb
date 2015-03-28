class Project < ActiveRecord::Base

  has_many :collaborations
  has_many :users, through: :collaborations

  has_many :invitations
  has_many :invites, through: :invitations, :source => :user

  validates_presence_of :name

end
