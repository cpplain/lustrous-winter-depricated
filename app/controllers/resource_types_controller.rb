class ResourceTypesController < ApplicationController
  def index
    render_success(:ok, ResourceType.order(resource_type: :asc))
  end

  def create
    resource_type = ResourceType.create(resource_type_params)
    return render_success(:created, resource_type) if resource_type.valid?
    render_error(:unprocessable_entity, resource_type.errors)
  end

  def update
    current_resource_type.update(resource_type_params)
    return render_success(:ok, current_resource_type) if current_resource_type.valid?
    render_error(:unprocessable_entity, current_resource_type.errors)
  end

  def destroy
    return render_error(:not_found) if current_resource_type.nil?
    current_resource_type.destroy
    render_success(:no_content)
  end

  private

  def resource_type_params
    params.require(:resource_type).permit(:resource_type)
  end

  def current_resource_type
    @current_resource_type ||= ResourceType.find_by_id(params[:id])
  end
end
