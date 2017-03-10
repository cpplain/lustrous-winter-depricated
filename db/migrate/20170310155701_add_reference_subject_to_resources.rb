class AddReferenceSubjectToResources < ActiveRecord::Migration[5.0]
  def change
    add_reference :resources, :subject, index: true
  end
end
