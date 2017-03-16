class AddReferenceAuthorToResources < ActiveRecord::Migration[5.0]
  def change
    add_reference :resources, :author, index: true
  end
end
