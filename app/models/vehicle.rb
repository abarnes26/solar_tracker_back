class Vehicle < ApplicationRecord
  validates_presence_of :make, :model, :mpg
  has_many :branch_vehicles
  has_many :branches, through: :branch_vehicles
  has_many :project_vehicles
  has_many :projects, through: :project_vehicles
end
