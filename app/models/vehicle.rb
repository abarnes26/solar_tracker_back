class Vehicle < ApplicationRecord
  validates_presence_of :make, :model, :mpg, :branch_id
  belongs_to :branch
  has_many :project_vehicles
  has_many :projects, through: :project_vehicles
end
