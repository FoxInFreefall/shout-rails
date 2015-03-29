class Invitation < Collaboration
  # Association macros
  belongs_to  :project
  belongs_to  :user
end
