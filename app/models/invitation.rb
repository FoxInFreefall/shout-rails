class Invitation < ActiveRecord::Base
  # Association macros
  belongs_to  :project
  belongs_to  :user
end
