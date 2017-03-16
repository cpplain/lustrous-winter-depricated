class ResourceTypesController < ApplicationController
  def index
    render_success(:ok, ResourceType.order(resource_type: :asc))
  end

  def create
    resource_type = ResourceType.create(resource_type_params)
    return render_success(:created, resource_type) if resource_type.valid?
    render_error(:unprocessable_entity, resource_type.errors)
  end

  private

  def resource_type_params
    params.require(:resource_type).permit(:resource_type)
  end
end
