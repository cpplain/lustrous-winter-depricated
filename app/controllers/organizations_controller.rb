class OrganizationsController < ApplicationController
  def index
    render_success(:ok, Organization.order(name: :asc))
  end
end
