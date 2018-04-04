require 'rails_helper'

describe "Branches API" do
  context "HTTP GET all" do
    it "sends a list of customers" do
      create_list(:branch, 3)

      get '/api/v1/branches'

      expect(response).to be_success

      branches = JSON.parse(response.body)

      expect(branches.count).to eq(3)
    end
  end

  context "HTTP GET one" do
    it "sends a list of customers" do
      branch_1 = create(:branch, street: "123 Solar Way")
      create(:branch, street: "123 Energy Drive")
      create(:branch, street: "123 Sunny Blvd")

      get "/api/v1/branches/#{branch_1.id}"

      expect(response).to be_success

      branch = JSON.parse(response.body)

      expect(branch['street']).to eq("123 Solar Way")
    end
  end

  context "HTTP POST" do
    it "creates a new branch" do

      expect(Branch.all.count).to eq(0)

      post "/api/v1/branches?branch[street]=123%20Solar%20Way&branch[city]=Denver&branch[state]=CO&branch[zipcode]=80202"

      expect(response).to be_success
      expect(response.body).to eq("Branch was successfully created!")
      expect(Branch.all.count).to eq(1)
      expect(Branch.first.street).to eq("123 Solar Way")
    end
  end

  context "HTTP PATCH" do
    it "updates an existing branch" do
      branch = create(:branch)
      expect(branch.street).to eq("15013 Denver W Pkwy")

      patch "/api/v1/branches/#{branch.id}?branch[street]=555%20Bright%20Way"

      expect(response).to be_success
      new_branch = JSON.parse(response.body)
      expect(new_branch['street']).to eq("555 Bright Way")
      expect(Branch.last.street).to eq("555 Bright Way")
    end
  end

  context "HTTP Delete" do
    it "updates an existing branch" do
      expect(Branch.all.count).to eq(0)
      branch_1 = create(:branch, street: "22 Hunter Way")
      branch_2 = create(:branch, street: "5505 Pleasing Palace Place")

      expect(Branch.all.count).to eq(2)

      delete "/api/v1/branches/#{branch_2.id}"

      expect(response).to be_success
      expect(response.body).to eq("Branch was successfully deleted!")
      expect(Branch.last.street).to eq("22 Hunter Way")
      expect(Branch.all.count).to eq(1)

    end
  end
end
