class AddColumnsToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :medium, :string
    add_column :resources, :author, :string
    add_column :resources, :isbn, :string
    add_column :resources, :organization, :string
    add_column :resources, :url, :string
    add_column :resources, :city, :string
    add_column :resources, :state, :string
    add_column :resources, :country, :string
    add_column :resources, :free, :boolean
  end
end
