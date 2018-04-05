require 'rails_helper'

describe Project do
  it "is assigned a solar data value as it is created" do
    project_1 = create(:project)

    expect(project_1.solar_data).to 
  end
end
