class BranchVehicle < ApplicationRecord
  belongs_to :branch
  belongs_to :vehicle
end
