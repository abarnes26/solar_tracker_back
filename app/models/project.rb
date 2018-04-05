class Project < ApplicationRecord
  validates_presence_of :street, :city, :state, :zipcode, :customer_name, :size_kW
  belongs_to :branch
  has_many :project_vehicles
  has_many :vehicles, through: :project_vehicles
  before_save :calc_energy_values

  def calc_energy_values
    assign_local_annual_irradiance
    assign_annual_production_kWh
    assign_system_carbon_kWh
    assign_total_system_carbon_impact
    build_energy_profile
    binding.pry
    assign_round_trip_miles
  end

  # irradiance is kWh/m2
  def assign_local_annual_irradiance
    self.local_annual_irradiance = (RetrieveIrradiance.new(self.zipcode).irradiance * 365).round(2)
  end

  # in this iteration, assuming solar modules are 1.5 m2, 14% eff, 240w panels
  def assign_annual_production_kWh
    self.annual_production_kWh = ((self.local_annual_irradiance * 0.14) * (((self.size_kW * 1000)/ 240) * 1.5)).round(2)
  end

  # '0.14' => module efficiency, '30' => lifespan of module in years,
  # '787.05' => lbs of carbon by producing one module, 453.592 => grams in a lb
  def assign_system_carbon_kWh
    self.system_carbon_g_per_kWh = (453.592 / (((self.local_annual_irradiance * 0.14) * 30) / 787.05)).round(2)
  end

  def assign_total_system_carbon_impact
    self.total_system_carbon_impact_g = ((((self.size_kW * 1000) / 240) * 787.05) * 453.592).round(2)
  end

  def build_energy_profile
    profile = RetrieveEnergyProfile.new(self.zipcode).energy_profile
    self.local_carbon_g_per_kWh = ((profile[:elec_lb_ghg] / (profile[:elec_mwh] * 1000)) * 453.592)
  end
end
