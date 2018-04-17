require 'rails_helper'

describe "Projects API" do
  context "HTTP GET all" do
    it "sends a list of projects" do
      VCR.use_cassette("get_all_projects") do
        branch = create(:branch)
        create(:project, branch: branch)
        create(:project, branch: branch)
        create(:project, branch: branch)


        get "/api/v1/branches/#{branch.id}/projects"

        expect(response).to be_success

        projects = JSON.parse(response.body)

        expect(projects.count).to eq(3)
      end
    end
  end

  context "HTTP GET one" do
    it "sends a list of projects" do
      VCR.use_cassette("get_one_projects") do
        branch = create(:branch)
        project_1 = create(:project, customer_name: "Hal Iday", branch: branch)
        create(:project, customer_name: "Toobe Young", branch: branch)
        create(:project, customer_name: "Joseph", branch: branch)

        get "/api/v1/branches/#{branch.id}/projects/#{project_1.id}"

        expect(response).to be_success

        project = JSON.parse(response.body)

        expect(project['customer_name']).to eq("Hal Iday")
      end
    end
  end

  context "HTTP POST" do
    it "creates a new project" do
      VCR.use_cassette("create_a_new_project") do
        branch = create(:branch)
        vehicle = create(:vehicle)
        pv_module = create(:pv_module)
        moduleName = pv_module.manufacturer + '-' + pv_module.model
        vehicleName = vehicle.make + '-' + vehicle.model

        expect(Project.all.count).to eq(0)

        post "/api/v1/branches/#{branch.id}/projects?project[street]=8279%20Iris%20St&project[city]=Arvada&project[state]=CO&project[zipcode]=80005&project[customer%5Fname]=Joseph&project[size%5FkW]=4&project[branch%5Fid]=#{branch.id}&project[number_of_pv_modules]=22&project[vehicleName]=#{vehicleName}&project[moduleName]=#{moduleName}"

        expect(response).to be_success
        expect(response.body).to eq("Project was successfully created!")
        expect(Project.all.count).to eq(1)
        expect(Project.first.customer_name).to eq("Joseph")
      end
    end
  end

  context "HTTP PATCH" do
    it "updates an existing project's name" do
      VCR.use_cassette("update_a_projects") do
        branch = create(:branch)
        project = create(:project, branch: branch)
        expect(project.customer_name).to eq("John Doe")

        patch "/api/v1/branches/#{branch.id}/projects/#{project.id}?project[customer_name]=Hal%20Iday"

        expect(response).to be_success
        new_project = JSON.parse(response.body)
        expect(new_project['customer_name']).to eq("Hal Iday")
        expect(Project.last.customer_name).to eq("Hal Iday")
      end
    end
  end

  context "HTTP PATCH" do
    it "updates an existing project's status" do
      VCR.use_cassette("update_a_projects_status") do
        branch = create(:branch)
        project = create(:project, branch: branch)
        expect(project.customer_name).to eq("John Doe")

        patch "/api/v1/branches/#{branch.id}/projects/#{project.id}?project[status]=complete"

        expect(response).to be_success
        new_project = JSON.parse(response.body)
        expect(new_project['status']).to eq("complete")
        expect(Project.last.status).to eq("complete")
      end
    end

    it "is totals carbon impact once it is completed" do
      VCR.use_cassette("project_model_total_carbon") do
        branch = create(:branch)
        project = create(:project, zipcode: 80003, branch: branch)

        patch "/api/v1/branches/#{branch.id}/projects/#{project.id}?project[status]=complete"

        expect(response).to be_success
        new_project = JSON.parse(response.body)
        expect(new_project['status']).to eq("complete")
        expect(new_project['total_system_carbon_impact_g']).to eq(13117425.95)
      end
    end
  end

  context "HTTP PATCH" do
    it "updates an existing project's age" do
      VCR.use_cassette("update_a_projects_status") do
        branch = create(:branch)
        project = create(:project, branch: branch)
        expect(project.age_days).to eq(1)

        patch "/api/v1/branches/#{branch.id}/projects/#{project.id}?project[age_days]=3"

        expect(response).to be_success
        new_project = JSON.parse(response.body)
        expect(new_project['age_days']).to eq(3)
        expect(Project.last.age_days).to eq(3)
      end
    end
  end

  context "HTTP Delete" do
    it "deletes an existing project" do
      VCR.use_cassette("delete_a_project") do
        expect(Project.all.count).to eq(0)
        branch = create(:branch)
        project_1 = create(:project, customer_name: "22 Hunter Way", branch: branch)
        project_2 = create(:project, customer_name: "5505 Pleasing Palace Place", branch: branch)

        expect(Project.all.count).to eq(2)

        delete "/api/v1/branches/#{branch.id}/projects/#{project_2.id}"

        expect(response).to be_success
        expect(response.body).to eq("Project was successfully deleted!")
        expect(Project.last.customer_name).to eq("22 Hunter Way")
        expect(Project.all.count).to eq(1)
      end
    end
  end
end
