class AddReferenceToResources < ActiveRecord::Migration[5.0]
  def change
    add_reference :resources, :resource_type, index: true
  end
end
