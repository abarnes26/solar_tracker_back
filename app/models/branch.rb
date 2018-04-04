class Branch < ApplicationRecord
  validates_presence_of :street, :city, :state, :zipcode
  has_many :projects
  has_many :branch_vehicles
  has_many :vehicles, through: :branch_vehicles

end
