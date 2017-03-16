class AddReferenceOrganizationToResources < ActiveRecord::Migration[5.0]
  def change
    add_reference :resources, :organization, index: true
  end
end
