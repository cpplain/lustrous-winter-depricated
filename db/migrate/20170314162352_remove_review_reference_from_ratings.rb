class RemoveReviewReferenceFromRatings < ActiveRecord::Migration[5.0]
  def change
    remove_reference :ratings, :review
  end
end
