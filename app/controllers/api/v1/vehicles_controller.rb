class Api::V1::VehiclesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Vehicle.all
  end

  def show
    render json: Vehicle.find(params[:id])
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    branch = Branch.find(params['branch_id'])
    @vehicle.branch_id = branch.id
    if @vehicle.save
      render json: "Vehicle was successfully created!"
    else
      render json: "Vehicle was not created, please try again"
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: "Something went wrong, please try again"
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    render json: "Vehicle was successfully deleted!"
  end

  private
    def vehicle_params
      params.require(:vehicle).permit(:branch_id, :make, :model, :mpg)
    end


end
