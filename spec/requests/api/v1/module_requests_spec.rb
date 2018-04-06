require 'rails_helper'

describe "Modules API" do
  context "HTTP GET all" do
    it "sends a list of pv_modules" do
      VCR.use_cassette("get_all_pv_modules") do

        create_list(:pv_module, 3)

        get '/api/v1/pv_modules'

        expect(response).to be_success

        pv_modules = JSON.parse(response.body)

        expect(pv_modules.count).to eq(3)
      end
    end
  end

  context "HTTP GET one" do
    it "sends a list of pv_modules" do
      VCR.use_cassette("get_one_pv_modules") do
        pv_module = create(:project, model: "TP 275w")
        create(:pv_module, model: "TP 260w")
        create(:pv_module, model: "TP 280w")

        get "/api/v1/pv_modules/#{pv_module.id}"

        expect(response).to be_success

        pv_module_1 = JSON.parse(response.body)

        expect(pv_module_1['model']).to eq("TP 275w")
      end
    end
  end

  context "HTTP POST" do
    it "creates a new project" do
      VCR.use_cassette("create_a_new_project") do
        branch = create(:branch)
        vehicle = create(:vehicle)

        expect(Project.all.count).to eq(0)

        post "/api/v1/pv_modules?project[street]=8279%20Iris%20St&project[city]=Arvada&project[state]=CO&project[zipcode]=80005&project[customer%5Fname]=Joseph&project[size%5FkW]=4&project[branch%5Fid]=#{branch.id}&vehicle[:id]=#{vehicle.id}"

        expect(response).to be_success
        expect(response.body).to eq("Project was successfully created!")
        expect(Project.all.count).to eq(1)
        expect(Project.first.customer_name).to eq("Joseph")
      end
    end
  end

  context "HTTP PATCH" do
    it "updates an existing project" do
      VCR.use_cassette("update_a_pv_modules") do
        project = create(:project)
        expect(project.customer_name).to eq("John Doe")

        patch "/api/v1/pv_modules/#{project.id}?project[customer_name]=Hal%20Iday"

        expect(response).to be_success
        new_project = JSON.parse(response.body)
        expect(new_project['customer_name']).to eq("Hal Iday")
        expect(Project.last.customer_name).to eq("Hal Iday")
      end
    end
  end

  context "HTTP Delete" do
    it "deletes an existing project" do
      VCR.use_cassette("delete_a_project") do
        expect(Project.all.count).to eq(0)
        project_1 = create(:project, customer_name: "22 Hunter Way")
        project_2 = create(:project, customer_name: "5505 Pleasing Palace Place")

        expect(Project.all.count).to eq(2)

        delete "/api/v1/pv_modules/#{project_2.id}"

        expect(response).to be_success
        expect(response.body).to eq("Project was successfully deleted!")
        expect(Project.last.customer_name).to eq("22 Hunter Way")
        expect(Project.all.count).to eq(1)
      end
    end
  end
end
