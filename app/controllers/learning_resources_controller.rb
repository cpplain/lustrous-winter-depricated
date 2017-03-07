class LearningResourcesController < ApplicationController
  def index
    render json: LearningResource.all
  end

  def create
    learning_resource = LearningResource.create(learning_resource_params)
    render json: learning_resource
  end

  def update
    current_learning_resource.update_attributes(learning_resource_params)
    render json: current_learning_resource
  end

  def destroy
    current_learning_resource.destroy
  end

  private

  def learning_resource_params
    params.require(:learning_resource).permit(:name, :description)
  end

  def current_learning_resource
    @current_learning_resource ||= LearningResource.find(params[:id])
  end
end
