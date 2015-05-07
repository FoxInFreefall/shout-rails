ActiveAdmin.register Task do
  permit_params :name, :list
  menu priority: 5

end
