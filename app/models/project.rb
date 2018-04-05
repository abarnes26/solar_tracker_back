class Project < ApplicationRecord
  validates_presence_of :street, :city, :state, :zipcode, :customer_name, :size_kW
  belongs_to :branch
  has_many :project_vehicles
  has_many :vehicles, through: :project_vehicles
end
