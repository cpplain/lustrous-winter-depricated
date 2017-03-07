class ResourcesController < ApplicationController
  def index
    render json: Resource.all
  end

  def create
    resource = Resource.create(resource_params)
    render json: resource
  end

  def update
    current_resource.update_attributes(resource_params)
    render json: current_resource
  end

  def destroy
    current_resource.destroy
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :description)
  end

  def current_resource
    @current_resource ||= Resource.find(params[:id])
  end
end
