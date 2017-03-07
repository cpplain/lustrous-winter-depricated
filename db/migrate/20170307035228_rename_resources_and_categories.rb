class RenameResourcesAndCategories < ActiveRecord::Migration[5.0]
  def change
    rename_table :resources, :learning_resources
    rename_table :categories, :resource_categories
  end
end
