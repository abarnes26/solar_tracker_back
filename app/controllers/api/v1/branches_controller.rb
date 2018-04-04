class Api::V1::BranchesController < ApplicationController

  def index
    render json: Branch.all
  end

  private
    # def branch_params
    #   params.require(:branch).permit(:id, :user_id, )
    # end


end
