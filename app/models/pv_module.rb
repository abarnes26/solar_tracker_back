class PvModule < ApplicationRecord
  validates_presence_of :output_w, :manufacturer, :model, :width_mm, :length_mm
  has_many :projects
  has_many :branch_pv_modules
  has_many :branches, through: :branch_pv_modules

end
