require 'rails_helper'

describe "Modules API" do
  context "HTTP GET all" do
    it "sends a list of pv_modules" do
      VCR.use_cassette("get_all_pv_modules") do
        branch = create(:branch)
        create(:pv_module, branch: branch)
        create(:pv_module, branch: branch)
        create(:pv_module, branch: branch)

        get "/api/v1/branches/#{branch.id}/pv_modules"

        expect(response).to be_success

        pv_modules = JSON.parse(response.body)

        expect(pv_modules.count).to eq(3)
      end
    end
  end

  context "HTTP GET one" do
    it "sends a single pv_module" do
      VCR.use_cassette("get_one_pv_modules") do
        branch = create(:branch)
        pv_module = create(:pv_module, model: "TP 275w", branch: branch)
        create(:pv_module, model: "TP 260w", branch: branch)
        create(:pv_module, model: "TP 280w", branch: branch)

        get "/api/v1/branches/#{branch.id}/pv_modules/#{pv_module.id}"

        expect(response).to be_success

        pv_module_1 = JSON.parse(response.body)

        expect(pv_module_1['model']).to eq("TP 275w")
      end
    end
  end

  context "HTTP POST" do
    it "creates a new module" do
      VCR.use_cassette("create_a_new_pv_module") do
        branch = create(:branch)

        expect(PvModule.all.count).to eq(0)

        post "/api/v1/branches/#{branch.id}/pv_modules?pv_module[output%5Fw]=250&pv_module[manufacturer]=REC&pv_module[model]=250%20TP&pv_module[efficiency]=0%2E18&pv_module[width_mm]=997&pv_module[length_mm]=1675"

        expect(response).to be_success
        expect(response.body).to eq("PV Module was successfully created!")
        expect(PvModule.all.count).to eq(1)
        expect(branch.pv_modules.count).to eq(1)
        expect(PvModule.first.model).to eq("250 TP")
      end
    end
  end

  context "HTTP PATCH" do
    it "updates an existing pv_module" do
      VCR.use_cassette("update_a_pv_modules") do
        branch = create(:branch)
        pv_module = create(:pv_module, branch: branch)
        expect(pv_module.manufacturer).to eq("REC")

        patch "/api/v1/branches/#{branch.id}/pv_modules/#{pv_module.id}?pv_module[manufacturer]=Sungevity"

        expect(response).to be_success
        new_pv_module = JSON.parse(response.body)
        expect(new_pv_module['manufacturer']).to eq("Sungevity")
        expect(PvModule.last.manufacturer).to eq("Sungevity")
      end
    end
  end

  context "HTTP Delete" do
    it "deletes an existing pv_module" do
      VCR.use_cassette("delete_a_pv_module") do
        expect(PvModule.all.count).to eq(0)
        branch = create(:branch)
        pv_module_1 = create(:pv_module, manufacturer: "REC", branch: branch)
        pv_module_2 = create(:pv_module, manufacturer: "Sungevity", branch: branch)

        expect(PvModule.all.count).to eq(2)

        delete "/api/v1/branches/#{branch.id}/pv_modules/#{pv_module_2.id}"

        expect(response).to be_success
        expect(response.body).to eq("PV Module was successfully deleted!")
        expect(PvModule.last.manufacturer).to eq("REC")
        expect(PvModule.all.count).to eq(1)
      end
    end
  end
end
