class OrganizationsController < ApplicationController
  def index
    render_success(:ok, Organization.order(name: :asc))
  end

  def create
    organization = Organization.create(organization_params)
    return render_success(:created, organization) if organization.valid?
    render_error(:unprocessable_entity, organization.errors)
  end

  def update
    current_organization.update(organization_params)
    return render_success(:ok, current_organization) if current_organization.valid?
    render_error(:unprocessable_entity, current_organization.errors)
  end

  def destroy
    return render_error(:not_found) if current_organization.nil?
    current_organization.destroy
    render_success(:no_content)
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end

  def current_organization
    @current_organization ||= Organization.find_by_id(params[:id])
  end
end
