class PvModule < ApplicationRecord
  validates_presence_of :output_w, :manufacturer, :model, :width_mm, :length_mm
  has_many :projects
  belongs_to :branch

end
