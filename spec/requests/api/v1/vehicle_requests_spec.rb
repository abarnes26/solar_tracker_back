require 'rails_helper'

describe "Vehicles API" do
  context "HTTP GET all" do
    it "sends a list of vehicles" do
      branch = create(:branch)
      create(:vehicle, branch: branch)
      create(:vehicle, branch: branch)
      create(:vehicle, branch: branch)

      get "/api/v1/branches/#{branch.id}/vehicles"

      expect(response).to be_success

      vehicles = JSON.parse(response.body)

      expect(vehicles.count).to eq(3)
    end
  end

  context "HTTP GET one" do
    it "sends a list of vehicles" do
      branch = create(:branch)
      vehicle_1 = create(:vehicle, make: "Toyota", branch: branch)
      create(:vehicle, make: "Mercedes", branch: branch)
      create(:vehicle, make: "Honda", branch: branch)

      get "/api/v1/branches/#{branch.id}/vehicles/#{vehicle_1.id}"

      expect(response).to be_success

      vehicle = JSON.parse(response.body)

      expect(vehicle['make']).to eq("Toyota")
    end
  end

  context "HTTP POST" do
    it "creates a new vehicle" do
      branch = create(:branch)
      expect(Vehicle.all.count).to eq(0)

      post "/api/v1/branches/#{branch.id}/vehicles?vehicle[make]=Ford&vehicle[model]=fusion&vehicle[mpg]=35"

      expect(response).to be_success
      expect(response.body).to eq("Vehicle was successfully created!")
      expect(Vehicle.all.count).to eq(1)
      expect(branch.vehicles.count).to eq(1)
      expect(Vehicle.first.make).to eq("Ford")
    end
  end

  context "HTTP PATCH" do
    it "updates an existing vehicle" do
      branch = create(:branch)
      vehicle = create(:vehicle, branch: branch)
      expect(vehicle.make).to eq("Mercedes")

      patch "/api/v1/branches/#{branch.id}/vehicles/#{vehicle.id}?vehicle[make]=Toyota"

      expect(response).to be_success
      new_vehicle = JSON.parse(response.body)
      expect(new_vehicle['make']).to eq("Toyota")
      expect(Vehicle.last.make).to eq("Toyota")
    end
  end

  context "HTTP Delete" do
    it "deletes an existing vehicle" do
      branch = create(:branch)
      expect(Vehicle.all.count).to eq(0)
      vehicle_1 = create(:vehicle, make: "22 Hunter Way", branch: branch)
      vehicle_2 = create(:vehicle, make: "5505 Pleasing Palace Place", branch: branch)

      expect(Vehicle.all.count).to eq(2)

      delete "/api/v1/branches/#{branch.id}/vehicles/#{vehicle_2.id}"

      expect(response).to be_success
      expect(response.body).to eq("Vehicle was successfully deleted!")
      expect(Vehicle.last.make).to eq("22 Hunter Way")
      expect(Vehicle.all.count).to eq(1)
    end
  end
end
