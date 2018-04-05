require 'rails_helper'

describe "Vehicles API" do
  context "HTTP GET all" do
    it "sends a list of vehicles" do
      create_list(:vehicle, 3)

      get '/api/v1/vehicles'

      expect(response).to be_success

      vehicles = JSON.parse(response.body)

      expect(vehicles.count).to eq(3)
    end
  end

  context "HTTP GET one" do
    it "sends a list of vehicles" do
      vehicle_1 = create(:vehicle, make: "Toyota")
      create(:vehicle, make: "Mercedes")
      create(:vehicle, make: "Honda")

      get "/api/v1/vehicles/#{vehicle_1.id}"

      expect(response).to be_success

      vehicle = JSON.parse(response.body)

      expect(vehicle['make']).to eq("Toyota")
    end
  end

  context "HTTP POST" do
    it "creates a new vehicle" do

      expect(Vehicle.all.count).to eq(0)

      post "/api/v1/vehicles?vehicle[make]=Ford&vehicle[model]=fusion&vehicle[mpg]=35"

      expect(response).to be_success
      expect(response.body).to eq("Vehicle was successfully created!")
      expect(Vehicle.all.count).to eq(1)
      expect(Vehicle.first.make).to eq("Ford")
    end
  end

  context "HTTP PATCH" do
    it "updates an existing vehicle" do
      vehicle = create(:vehicle)
      expect(vehicle.make).to eq("Mercedes")

      patch "/api/v1/vehicles/#{vehicle.id}?vehicle[make]=Toyota"

      expect(response).to be_success
      new_vehicle = JSON.parse(response.body)
      expect(new_vehicle['make']).to eq("Toyota")
      expect(Vehicle.last.make).to eq("Toyota")
    end
  end

  context "HTTP Delete" do
    it "deletes an existing vehicle" do
      expect(Vehicle.all.count).to eq(0)
      vehicle_1 = create(:vehicle, make: "22 Hunter Way")
      vehicle_2 = create(:vehicle, make: "5505 Pleasing Palace Place")

      expect(Vehicle.all.count).to eq(2)

      delete "/api/v1/vehicles/#{vehicle_2.id}"

      expect(response).to be_success
      expect(response.body).to eq("Vehicle was successfully deleted!")
      expect(Vehicle.last.make).to eq("22 Hunter Way")
      expect(Vehicle.all.count).to eq(1)
    end
  end
end
