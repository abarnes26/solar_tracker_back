class Project < ApplicationRecord
  validates_presence_of :street, :city, :state, :zipcode, :customer_name, :size_kW
  belongs_to :branch
  belongs_to :pv_module
  has_many :project_vehicles
  has_many :vehicles, through: :project_vehicles
  before_save :calc_energy_values

  def calc_energy_values
    assign_local_annual_irradiance
    assign_annual_production_kWh
    assign_system_carbon_kWh
    build_energy_profile
    assign_round_trip_miles
  end

  def pv_module_lifespan
    30
  end

  def grams_in_a_pound
    453.592
  end

  def pounds_of_carbon_from_one_gallon_of_gas
    20
  end

  #NREL > Life Cycle Greenhouse Gas Emissions From Solar
  def pounds_of_carbon_from_one_solar_panel
    787.05
  end

  def days_in_one_year
    365
  end

  def annual_irradiance
    (average_irradiance_by_zipcode * days_in_one_year).round(2)
  end

  def assign_local_annual_irradiance # irradiance is represented in kWh/m2
    self.local_annual_irradiance = annual_irradiance
  end

  def average_irradiance_by_zipcode
    RetrieveIrradiance.new(self.zipcode).irradiance
  end

  def assign_annual_production_kWh
    self.annual_production_kWh = total_annual_production
  end

  def total_annual_production
    annual_production_from_one_panel * self.number_of_pv_modules
  end

  def annual_production_from_one_panel
    (wattage_captured_by_square_meter * area_of_pv_module_meters_squared).round(2)
  end

  def area_of_array_in_meters_squared
    self.number_of_pv_modules * area_of_pv_module_meters_squared
  end

  def wattage_captured_by_square_meter
    self.local_annual_irradiance * self.pv_module.efficiency
  end

  def area_of_pv_module_milimeters_squared
    self.pv_module.width_mm.to_f * self.pv_module.length_mm
  end

  def area_of_pv_module_meters_squared
    area_of_pv_module_milimeters_squared / 10**6
  end

  def total_lifetime_production_by_square_meter
    (wattage_captured_by_square_meter * pv_module_lifespan)
  end

  def lifetime_production_from_one_module
    annual_production_from_one_panel * pv_module_lifespan
  end

  def kWh_produced_per_pound_of_carbon_produced
    lifetime_wattage_per_square_meter / pounds_of_carbon_from_one_solar_panel.to_f
  end

  def lifetime_wattage_per_square_meter
    wattage_captured_by_square_meter * pv_module_lifespan
  end

  def grams_of_carbon_produced_per_kWh_produced
    (grams_in_a_pound / kWh_produced_per_pound_of_carbon_produced).round(2)
  end

  def assign_system_carbon_kWh
    unless self.system_carbon_g_per_kWh
      self.system_carbon_g_per_kWh = grams_of_carbon_produced_per_kWh_produced
    end
  end

  def assign_round_trip_miles
    self.round_trip_miles = (RetrieveTripMiles.new(self).get_distance * 2)
  end

  def local_carbon_gen_from_elec_gen_pounds
    profile = RetrieveEnergyProfile.new(self.zipcode).energy_profile
    profile[:elec_lb_ghg].to_f / (profile[:elec_mwh] * 1000)
  end

  def local_carbon_offput_from_elec_gen_grams
    (local_carbon_gen_from_elec_gen_pounds * grams_in_a_pound).round(2)
  end

  def build_energy_profile
    self.local_carbon_g_per_kWh = local_carbon_offput_from_elec_gen_grams
  end

  def total_gas_gallons_consumed
    self.vehicles.map { |vehicle| (self.round_trip_miles.to_f / vehicle.mpg) }.sum
  end

  def grams_of_carbon_from_one_gallon_of_gas
    pounds_of_carbon_from_one_gallon_of_gas * grams_in_a_pound
  end

  def grams_of_carbon_from_one_day_of_the_project
    total_gas_gallons_consumed * grams_of_carbon_from_one_gallon_of_gas
  end

  def lifetime_production_from_system
    lifetime_production_from_one_module * self.number_of_pv_modules
  end

  def total_vehicle_carbon_for_project_g
    (grams_of_carbon_from_one_day_of_the_project * self.age_days).round(2)
  end

  def carbon_produced_by_all_pv_modules_g
    self.system_carbon_g_per_kWh * lifetime_production_from_system
  end

  def total_carbon_for_system_g
    carbon_produced_by_all_pv_modules_g + total_vehicle_carbon_for_project_g
  end

  def assign_total_system_carbon_impact
    self.total_system_carbon_impact_g = total_carbon_for_system_g
  end
end
