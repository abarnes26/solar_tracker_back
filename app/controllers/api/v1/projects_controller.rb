class Api::V1::ProjectsController < ApplicationController

  def index
    render json: Project.all
  end

  def show
    render json: Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      ProjectVehicle.create(project: @project, vehicle_id: vehicle_params)
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
      params.require(:project).permit(:street, :city, :state, :zipcode, :customer_name, :size_kW, :branch_id)
    end

    def vehicle_params
      params.require(:vehicle).permit(:id)
    end


end
