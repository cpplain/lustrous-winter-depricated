class ResourceTypesController < ApplicationController
  def index
    render_success(:ok, ResourceType.order(resource_type: :asc))
  end
end
