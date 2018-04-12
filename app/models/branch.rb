class Branch < ApplicationRecord
  validates_presence_of :street, :city, :state, :zipcode
  has_many :projects
  has_many :pv_modules
  has_many :vehicles

end
