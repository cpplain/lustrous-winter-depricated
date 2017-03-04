class ResourcesController < ApplicationController
  def index
    render json: Resource.all
  end

  def create
    resource = Resource.create(resource_params)
    render json: resource
  end

  def update
    resource = Resource.find(params[:id]) 
    resource.update_attributes(resource_params)
    render json: resource
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :description)
  end
end
