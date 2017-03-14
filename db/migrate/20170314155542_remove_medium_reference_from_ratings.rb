class RemoveMediumReferenceFromRatings < ActiveRecord::Migration[5.0]
  def change
    remove_reference :ratings, :medium
  end
end
