ActiveAdmin.register Task do
  permit_params :name
  menu priority: 5

end
