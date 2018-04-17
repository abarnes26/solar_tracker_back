class Api::V1::ProjectsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Project.all
  end

  def show
    render json: Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    @project.pv_module_id = module_id_lookup
    if @project.save
      ProjectVehicle.create(project: @project, vehicle_id: vehicle_id_lookup)
      render json: "Project was successfully created!"
    else
      render json: "Project was not created, please try again"
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      if project_params[:status] == 'complete'
        @project.assign_total_system_carbon_impact
      end
      render json: @project
    else
      render json: "Something went wrong, please try again"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    render json: "Project was successfully deleted!"
  end

  private
    def project_params
      params.require(:project).permit(:street, :city, :state, :zipcode, :status, :customer_name, :size_kW, :branch_id, :vehicle_id, :number_of_pv_modules)
    end

    def module_id_lookup
      manufacturer = params['project']['moduleName'].split('-')[0]
      model = params['project']['moduleName'].split('-')[1]
      PvModule.find_by(model: model, manufacturer: manufacturer).id
    end

    def vehicle_id_lookup
      make = params['project']['vehicleName'].split('-')[0]
      model = params['project']['vehicleName'].split('-')[1]
      Vehicle.find_by(make: make, model: model).id
    end


end
