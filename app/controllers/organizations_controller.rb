class OrganizationsController < ApplicationController
  def index
    render_success(:ok, Organization.order(name: :asc))
  end

  def create
    organization = Organization.create(organization_params)
    return render_success(:created, organization) if organization.valid?
    render_error(:unprocessable_entity, organization.errors)
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
