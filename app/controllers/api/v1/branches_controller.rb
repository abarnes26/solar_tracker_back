class Api::V1::BranchesController < ApplicationController

  def index
    render json: Branch.all
  end

  def show
    render json: Branch.find(params[:id])
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      # BranchUser.create(user: branch_params[:user_id], branch: @branch)
      render json: "Branch was successfully created!"
    else
      render json: "Branch was not created, please try again"
    end
  end

  private
    def branch_params
      params.require(:branch).permit(:id, :user_id, :street, :city, :state, :zipcode)
    end


end
