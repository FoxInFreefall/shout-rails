class Task < ActiveRecord::Base
  # Association macros
  has_many :assignments
  has_many :members, through: :assignments, :source => :user

  belongs_to :project

  # Validation macros
  validates :title, presence: true

  # Scopes
  scope :todo, -> { where(list: 'todo') }
  scope :doing, -> { where(list: 'doing') }
  scope :done, -> { where(list: 'done') }
end
