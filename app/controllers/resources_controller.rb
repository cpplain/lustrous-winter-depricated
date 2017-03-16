class ResourcesController < ApplicationController
  def index
    render_success(:ok, Resource.order(name: :asc))
  end

  def create
    resource = Resource.create(resource_params)
    return render_success(:created, resource) if resource.valid?
    render_error(:unprocessable_entity, resource.errors)
  end

  def show
    return render_success(:ok, current_resource) if current_resource
    render_error(:not_found)
  end

  def update
    current_resource.update_attributes(resource_params)
    return render_success(:ok, current_resource) if current_resource.valid?
    render_error(:unprocessable_entity, current_resource.errors)
  end

  def destroy
    return render_error(:not_found) if current_resource.nil?
    current_resource.destroy
    render_success(:no_content)
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :description, :level, :free, :subject_id)
  end

  def current_resource
    @current_resource ||= Resource.find_by_id(params[:id])
  end
end
