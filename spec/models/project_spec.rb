require 'rails_helper'

describe Project do
  it "is gathers environmental data as it is created" do
    VCR.use_cassette("project_model_solar_data_check") do
      project = create(:project, zipcode: 80003)

      expect(project.local_annual_irradiance).to eq(2109.7)
      expect(project.local_carbon_g_per_kWh).to eq(830.79)
      expect(project.system_carbon_g_per_kWh).to eq(40.29)
      expect(project.annual_production_kWh).to eq(14620.22)
      expect(project.round_trip_miles).to eq(46.6)
    end
  end
end
