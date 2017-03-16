class RemoveColumnMediumAuthorOrganizationCityStateCountryFromResources < ActiveRecord::Migration[5.0]
  def change
    remove_column :resources, :medium
    remove_column :resources, :author
    remove_column :resources, :organization
    remove_column :resources, :city
    remove_column :resources, :state
    remove_column :resources, :country
    remove_reference :resources, :author
  end
end
