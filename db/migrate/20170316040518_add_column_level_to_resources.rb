class AddColumnLevelToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :level, :string
  end
end
