require 'rails_helper'

describe "Branches API" do
  context "HTTP GET" do
    it "sends a list of customers" do
      create_list(:branch, 3)

      get '/api/v1/branches'

      expect(response).to be_success

      branches = JSON.parse(response.body)

      expect(branches.count).to eq(3)
    end
  end
end
