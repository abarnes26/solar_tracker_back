class ProjectVehicle < ApplicationRecord
  belongs_to :project
  belongs_to :vehicle
end
