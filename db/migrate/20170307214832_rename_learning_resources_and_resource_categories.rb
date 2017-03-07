class RenameLearningResourcesAndResourceCategories < ActiveRecord::Migration[5.0]
  def change
    rename_table :learning_resources, :resources
    rename_table :resource_categories, :subjects
  end
end
