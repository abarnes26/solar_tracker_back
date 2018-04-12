class Api::V1::PvModulesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: PvModule.all
  end

  def show
    render json: PvModule.find(params[:id])
  end

  def create
    @pv_module = PvModule.new(pv_module_params)
    branch = Branch.find(params['branch_id'])
    @pv_module.branch_id = branch.id
    if @pv_module.save
      render json: "PV Module was successfully created!"
    else
      render json: "PV Module was not created, please try again"
    end
  end

  def update
    @pv_module = PvModule.find(params[:id])
    if @pv_module.update(pv_module_params)
      render json: @pv_module
    else
      render json: "Something went wrong, please try again"
    end
  end

  def destroy
    @pv_module = PvModule.find(params[:id])
    @pv_module.destroy
    render json: "PV Module was successfully deleted!"
  end

  private
    def pv_module_params
      params.require(:pv_module).permit(:output_w, :efficiency, :manufacturer, :model, :width_mm, :length_mm)
    end

    # def branch_params
    #   params.require(:branch).permit(:id)
    # end


end
