class Assignment < ActiveRecord::Base
  # Association macros
  belongs_to  :task
  belongs_to  :user
end
