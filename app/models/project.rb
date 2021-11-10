class Project < ApplicationRecord
  belongs_to :client, class_name: "User"
  belongs_to :creator, class_name: "User"
end
