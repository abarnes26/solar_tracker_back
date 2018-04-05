require 'rails_helper'

describe Project do
  it "is assigned a solar data value as it is created" do
    branch = create(:branch)
    vehicle = create(:vehicle)
    BranchVehicle.create(branch: branch, vehicle: vehicle)
    project = create(:project, branch: branch)
    ProjectVehicle.create(project: project, vehicle: vehicle)
    project.assign_total_system_carbon_impact
    binding.pry


    # expect(project_1.solar_data).to
  end
end
